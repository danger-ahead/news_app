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
    on<FetchNews>((event, emit) async {
      if (state.news[event.index] == null) {
        emit(state.copyWith(isLoading: true));
        final res = await _apiService.fetchNews(newsTopics[event.index]);

        final newsTopic = NewsTopic.fromJson(res);

        emit(state.copyWith(
          isLoading: false,
          news: {
            ...state.news,
            event.index: newsTopic,
          },
          index: event.index,
        ));
      } else {
        emit(state.copyWith(index: event.index));
      }
    });
  }
}
