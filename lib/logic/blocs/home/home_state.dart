part of 'home_bloc.dart';

class HomeState {
  const HomeState(
      {required this.isLoading, this.index = 0, this.news = const {}});

  final bool isLoading;
  final int index;
  final Map<int, NewsTopic> news;

  HomeState copyWith({
    bool? isLoading,
    int? index,
    Map<int, NewsTopic>? news,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      index: index ?? this.index,
      news: news ?? this.news,
    );
  }
}
