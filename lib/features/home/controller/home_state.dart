part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class MoviesGetPopularLoadingData extends HomeState {}

class MoviesGetPopularSuccessData extends HomeState {}

class MoviesGetPopularErrorData extends HomeState {
  final String? error;

  MoviesGetPopularErrorData({required this.error});
}

class MoviesGetTopRatedLoadingData extends HomeState {}

class MoviesGetTopRatedSuccessData extends HomeState {}

class MoviesGetTopDataErrorData extends HomeState {
  final String? error;

  MoviesGetTopDataErrorData({required this.error});
}

class MoviesGetUpComingLoadingData extends HomeState {}

class MoviesGetUpComingSuccessData extends HomeState {}

class MoviesGetUpComingErrorData extends HomeState {
  final String? error;

  MoviesGetUpComingErrorData({required this.error});
}

class MoviesGetNowPlayingLoadingData extends HomeState {}

class MoviesGetNowPlayingSuccessData extends HomeState {}

class MoviesGetNowPlayingErrorData extends HomeState {
  final String? error;

  MoviesGetNowPlayingErrorData({required this.error});
}

class MoviesGetTrendingLoadingData extends HomeState {}

class MoviesGetTrendingSuccessData extends HomeState {}

class MoviesGetTrendingErrorData extends HomeState {
  final String? error;

  MoviesGetTrendingErrorData({required this.error});
}

class ChangeCarouselState extends HomeState {}

class AddToWatchListLoadingState extends HomeState {}

class AddToWatchListSuccessState extends HomeState {
  final String mediaType;

  AddToWatchListSuccessState({required this.mediaType});
}

class AddToWatchListErrorState extends HomeState {
  final String? error;

  AddToWatchListErrorState({required this.error});
}

class GetWatchListLoadingState extends HomeState {}

class GetWatchListSuccessState extends HomeState {}

class GetWatchListErrorState extends HomeState {
  final String? error;

  GetWatchListErrorState({required this.error});
}

class FilterWatchListState extends HomeState {}

class DeleteWatchListLoadingState extends HomeState {}

class DeleteWatchListSuccessState extends HomeState {}

class DeleteWatchListErrorState extends HomeState {
  final String? error;

  DeleteWatchListErrorState({required this.error});
}

class ChangeWatchListErrorState extends HomeState {
  final String? error;

  ChangeWatchListErrorState({required this.error});
}

class ChangeWatchListLocalState extends HomeState {}

class MoviesGetDetailsLoadingData extends HomeState {}

class MoviesGetDetailsSuccessData extends HomeState {}

class MoviesGetDetailsErrorData extends HomeState {
  final String? error;

  MoviesGetDetailsErrorData({required this.error});
}
