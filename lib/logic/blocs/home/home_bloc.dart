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
        /// storing the initial index to revert back to it if the fetching fails
        final initialIndex = state.index;

        emit(state.copyWith(isLoading: true, index: event.index));

        try {
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
          ));
        } catch (e) {
          emit(state.copyWith(isLoading: false, index: initialIndex));
        }
      } else {
        emit(state.copyWith(index: event.index));
      }
    });

    // Fetch more news when user scrolls to the bottom
    on<FetchMoreNews>((event, emit) async {
      final currentState = state;

      // Check if we have reached the max number of articles
      if (currentState.news[event.index]!.articles.length >=
          currentState.news[event.index]!.totalResults) {
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

        for (final i in newsTopic.articles) {
          updatedNews[event.index]!.articles.add(i);
        }

        emit(currentState.copyWith(
          news: updatedNews,
          pageNumber: event.pageNumber,
          isLoadingMore: false,
        ));
      } catch (e) {
        emit(currentState.copyWith(isLoadingMore: false));
      }
    });
  }
}
