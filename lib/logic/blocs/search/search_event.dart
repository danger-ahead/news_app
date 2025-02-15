part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchTextChanged extends SearchEvent {
  final String query;

  SearchTextChanged(this.query);
}

class FetchPreviousSearches extends SearchEvent {}

class PerformSearch extends SearchEvent {
  final String query;

  PerformSearch({required this.query});
}

class ClearSearch extends SearchEvent {}
