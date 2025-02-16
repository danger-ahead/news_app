import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/ui.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/data/providers/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _apiService = ApiService();

  // initially in the loading state before fetching any news content
  HomeBloc() : super(const HomeState(isLoading: true)) {
    // Fetch initial news
    on<FetchNews>((event, emit) async {
      if (state.news[event.index] == null) {
        emit(state.copyWith(isLoading: true));

        final res = await _apiService.fetchNews(
          newsTopics[event.index],
          page: 1,
        );

        final newsTopic = NewsTopic.fromJson(res);

        emit(state.copyWith(
          isLoading: false,
          news: {
            ...state.news,
            event.index: newsTopic,
          },
          index: event.index,
          totalArticles: newsTopic.totalResults,
        ));
      } else {
        emit(state.copyWith(index: event.index));
      }
    });

    // Fetch more news when user scrolls to the bottom
    on<FetchMoreNews>((event, emit) async {
      final currentState = state;

      // Check if we have reached the max number of articles
      if (currentState.news[event.index]!.articles.length >=
          currentState.totalArticles) {
        return; // Stop fetching
      }

      emit(currentState.copyWith(isLoadingMore: true));

      try {
        final res = await _apiService.fetchNews(
          newsTopics[event.index],
          page: event.pageNumber,
        );

        final newsTopic = NewsTopic.fromJson(res);

        final updatedNews = Map<int, NewsTopic>.from(currentState.news);
        // updatedNews[event.index] =
        //     currentState.news[event.index]!.copyWith(articles: updatedArticles);

        for (final i in newsTopic.articles) {
          updatedNews[event.index]!.articles.add(i);
        }

        emit(currentState.copyWith(
          news: updatedNews,
          pageNumber: event.pageNumber,
          isLoadingMore: false,
          totalArticles: newsTopic.totalResults,
        ));
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    });
  }
}
