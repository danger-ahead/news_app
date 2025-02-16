part of 'home_bloc.dart';

class HomeState {
  const HomeState({
    required this.isLoading,
    this.index = 0,
    this.news = const {},
    this.pageNumber = 1,
    this.isLoadingMore = false,
    this.totalArticles = 0,
  });

  final bool isLoading;
  final int index;
  final Map<int, NewsTopic> news;
  final int pageNumber;
  final bool isLoadingMore;
  final int totalArticles;

  HomeState copyWith({
    bool? isLoading,
    int? index,
    Map<int, NewsTopic>? news,
    int? pageNumber,
    bool? isLoadingMore,
    int? totalArticles,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      index: index ?? this.index,
      news: news ?? this.news,
      pageNumber: pageNumber ?? this.pageNumber,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      totalArticles: totalArticles ?? this.totalArticles,
    );
  }
}
