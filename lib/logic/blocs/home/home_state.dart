part of 'home_bloc.dart';

class HomeState {
  const HomeState({
    required this.isLoading,
    this.index = 0,
    this.news = const {},
    this.pageNumber = 1,
    this.isLoadingMore = false,
  });

  /// initial loading state
  final bool isLoading;

  /// current news topic tab index
  final int index;

  /// news topics stored by index
  final Map<int, NewsTopic> news;

  /// current page number
  final int pageNumber;

  /// user has scrolled to the bottom and we are fetching more news
  final bool isLoadingMore;

  HomeState copyWith({
    bool? isLoading,
    int? index,
    Map<int, NewsTopic>? news,
    int? pageNumber,
    bool? isLoadingMore,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      index: index ?? this.index,
      news: news ?? this.news,
      pageNumber: pageNumber ?? this.pageNumber,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}
