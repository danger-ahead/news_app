part of 'home_bloc.dart';

abstract class HomeEvent {
  const HomeEvent();
}

class FetchNews extends HomeEvent {
  const FetchNews({required this.index});

  final int index;
}

class FetchMoreNews extends HomeEvent {
  const FetchMoreNews({required this.index, required this.pageNumber});

  final int index;
  final int pageNumber;
}
