part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class MoviesGetTopSearchLoadingData extends SearchState {}

class MoviesGetTopSearchSuccessData extends SearchState {}

class MoviesGetTopSearchErrorData extends SearchState {
  final String? error;

  MoviesGetTopSearchErrorData({required this.error});
}

class MoviesGetMultiSearchLoadingData extends SearchState {}

class MoviesGetMultiSearchSuccessData extends SearchState {}

class MoviesGetMultiSearchErrorData extends SearchState {
  final String? error;

  MoviesGetMultiSearchErrorData({required this.error});
}

class ClearSearchFieldState extends SearchState {}

