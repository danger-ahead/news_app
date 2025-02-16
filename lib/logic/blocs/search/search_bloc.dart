import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:news_app/core/notifications/toast.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/data/providers/api_service.dart';
import 'package:news_app/data/providers/hive_storage.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final _apiService = ApiService();
  final _logger = Logger();

  SearchBloc() : super(const SearchState()) {
    on<FetchPreviousSearches>((event, emit) async {
      emit(state.copyWith(
          previousSearches: HiveStorageService().getPreviousSearches()));
    });

    on<PerformSearch>((event, emit) async {
      emit(state.copyWith(isSearching: true, searchQuery: event.query));

      if (event.query.isEmpty) {
        ShowToast.error("Search query cannot be empty");
        return;
      } else if (state.news[event.query] != null) {
        emit(state.copyWith(
            currentResults: state.news[event.query], isSearching: false));
        return;
      }

      try {
        final searchResults =
            NewsTopic.fromJson(await _apiService.fetchNews(event.query));

        await HiveStorageService().savePreviousSearches(event.query);

        emit(state.copyWith(
            isSearching: false,
            previousSearches: HiveStorageService().getPreviousSearches(),
            currentResults: searchResults,
            // cache the search results
            news: {...state.news, event.query: searchResults}));
      } catch (e) {
        emit(state.copyWith(
            isSearching: false, searchQuery: '', currentResults: null));
        _logger.e(e);
        ShowToast.error("Unable to fetch news with the given query");
      }
    });

    on<ClearSearch>((event, emit) async {
      emit(state.copyWith(
          currentResults: null,
          isSearching: false,
          searchQuery: '',
          previousSearches: HiveStorageService().getPreviousSearches()));
    });
  }
}
