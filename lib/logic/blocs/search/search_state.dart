part of 'search_bloc.dart';

class SearchState {
  const SearchState({
    this.previousSearches = const [],
    this.isSearching = false,
    this.searchQuery = '',
    this.news = const {},
    this.currentResults,
  });

  final List<String> previousSearches;
  final bool isSearching;
  final String searchQuery;

  /// news topic search results stored by search query
  final Map<String, NewsTopic> news;

  /// current search results being shown in the UI
  final NewsTopic? currentResults;

  SearchState copyWith({
    List<String>? previousSearches,
    bool? isSearching,
    String? searchQuery,
    Map<String, NewsTopic>? news,
    NewsTopic? currentResults,
  }) {
    return SearchState(
      previousSearches: previousSearches ?? this.previousSearches,
      isSearching: isSearching ?? this.isSearching,
      searchQuery: searchQuery ?? this.searchQuery,
      news: news ?? this.news,
      currentResults: currentResults,
    );
  }
}
