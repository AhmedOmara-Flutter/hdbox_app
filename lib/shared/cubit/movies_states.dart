abstract class MoviesState {}

class InitialState extends MoviesState {}

class ChangeBottomNavBarState extends MoviesState {}
class ChangeCarouselState extends MoviesState {}

class ChangeOnBoardingSlidesState extends MoviesState {}

class MoviesLoadedState extends MoviesState {}

class MoviesErrorState extends MoviesState {
  final String error;

  MoviesErrorState({required this.error});
}

class MoviesGetPopularLoadingData extends MoviesState {}

class MoviesGetPopularSuccessData extends MoviesState {}

class MoviesGetPopularErrorData extends MoviesState {
  final String? error;

  MoviesGetPopularErrorData({required this.error});
}

class MoviesGetTopRatedLoadingData extends MoviesState {}

class MoviesGetTopRatedSuccessData extends MoviesState {}

class MoviesGetTopDataErrorData extends MoviesState {
  final String? error;

  MoviesGetTopDataErrorData({required this.error});
}

class MoviesGetDetailsLoadingData extends MoviesState {}

class MoviesGetDetailsSuccessData extends MoviesState {}

class MoviesGetDetailsErrorData extends MoviesState {
  final String? error;

  MoviesGetDetailsErrorData({required this.error});
}

class MoviesGetUpComingLoadingData extends MoviesState {}

class MoviesGetUpComingSuccessData extends MoviesState {}

class MoviesGetUpComingErrorData extends MoviesState {
  final String? error;

  MoviesGetUpComingErrorData({required this.error});
}

class MoviesGetTopSearchLoadingData extends MoviesState {}

class MoviesGetTopSearchSuccessData extends MoviesState {}

class MoviesGetTopSearchErrorData extends MoviesState {
  final String? error;

  MoviesGetTopSearchErrorData({required this.error});
}

class MoviesGetSearchLoadingData extends MoviesState {}

class MoviesGetSearchSuccessData extends MoviesState {}

class MoviesGetSearchErrorData extends MoviesState {
  final String? error;

  MoviesGetSearchErrorData({required this.error});
}

class MoviesGetCreditsLoadingData extends MoviesState {}

class MoviesGetCreditsSuccessData extends MoviesState {}

class MoviesGetCreditsErrorData extends MoviesState {
  final String? error;

  MoviesGetCreditsErrorData({required this.error});
}

class MoviesGetSimilarLoadingData extends MoviesState {}

class MoviesGetSimilarSuccessData extends MoviesState {}

class MoviesGetSimilarErrorData extends MoviesState {
  final String? error;

  MoviesGetSimilarErrorData({required this.error});
}

class MoviesGetPersonLoadingData extends MoviesState {}

class MoviesGetPersonSuccessData extends MoviesState {}

class MoviesGetPersonErrorData extends MoviesState {
  final String? error;

  MoviesGetPersonErrorData({required this.error});
}

class MoviesGetNowPlayingLoadingData extends MoviesState {}

class MoviesGetNowPlayingSuccessData extends MoviesState {}

class MoviesGetNowPlayingErrorData extends MoviesState {
  final String? error;

  MoviesGetNowPlayingErrorData({required this.error});
}

class MoviesGetTrendingLoadingData extends MoviesState {}

class MoviesGetTrendingSuccessData extends MoviesState {}

class MoviesGetTrendingErrorData extends MoviesState {
  final String? error;

  MoviesGetTrendingErrorData({required this.error});
}

class MoviesGetImagesLoadingData extends MoviesState {}

class MoviesGetImagesSuccessData extends MoviesState {}

class MoviesGetImagesErrorData extends MoviesState {
  final String? error;

  MoviesGetImagesErrorData({required this.error});
}

class MoviesGetNetworkLoadingData extends MoviesState {}

class MoviesGetNetworkSuccessData extends MoviesState {}

class MoviesGetNetworkErrorData extends MoviesState {
  final String? error;

  MoviesGetNetworkErrorData({required this.error});
}

class MoviesGetTvMoviesLoadingData extends MoviesState {}

class MoviesGetTvMoviesSuccessData extends MoviesState {}

class MoviesGetTvMoviesErrorData extends MoviesState {
  final String? error;

  MoviesGetTvMoviesErrorData({required this.error});
}

class MoviesGetSimilarTVLoadingData extends MoviesState {}

class MoviesGetSimilarTVSuccessData extends MoviesState {}

class MoviesGetSimilarTVErrorData extends MoviesState {
  final String? error;

  MoviesGetSimilarTVErrorData({required this.error});
}

class MoviesGetImagesTVLoadingData extends MoviesState {}

class MoviesGetImagesTVSuccessData extends MoviesState {}

class MoviesGetImagesTVErrorData extends MoviesState {
  final String? error;

  MoviesGetImagesTVErrorData({required this.error});
}

class MoviesGetEpisodeLoadingData extends MoviesState {}

class MoviesGetEpisodeSuccessData extends MoviesState {}

class MoviesGetEpisodeErrorData extends MoviesState {
  final String? error;

  MoviesGetEpisodeErrorData({required this.error});
}

class MoviesGetGenresListLoadingData extends MoviesState {}

class MoviesGetGenresListSuccessData extends MoviesState {}

class MoviesGetGenresListErrorData extends MoviesState {
  final String? error;

  MoviesGetGenresListErrorData({required this.error});
}

class MoviesGetGenresDataLoadingData extends MoviesState {}

class MoviesGetGenresDataSuccessData extends MoviesState {}

class MoviesGetGenresDataErrorData extends MoviesState {
  final String? error;

  MoviesGetGenresDataErrorData({required this.error});
}

//todo videos

class MoviesGetVideoMoviesTrailerDataLoadingData extends MoviesState {}

class MoviesGetVideoMoviesTrailerDataSuccessData extends MoviesState {}

class MoviesGetVideoMoviesTrailerDataErrorData extends MoviesState {
  final String? error;

  MoviesGetVideoMoviesTrailerDataErrorData({required this.error});
}

class MoviesGetVideoTVEpisodeLoadingData extends MoviesState {}

class MoviesGetVideoTVEpisodeSuccessData extends MoviesState {}

class MoviesGetVideoTVEpisodeErrorData extends MoviesState {
  final String? error;

  MoviesGetVideoTVEpisodeErrorData({required this.error});
}

class MoviesGetVideoTVLoadingData extends MoviesState {}

class MoviesGetVideoTVSuccessData extends MoviesState {}

class MoviesGetVideoTVErrorData extends MoviesState {
  final String? error;

  MoviesGetVideoTVErrorData({required this.error});
}

class GetUserDataLoadingState extends MoviesState {}

class GetUserDataSuccessState extends MoviesState {}

class GetUserDataErrorState extends MoviesState {
  final String? error;

  GetUserDataErrorState({required this.error});
}

class ResetCurrentIndexState extends MoviesState {}

class ResetUserModelState extends MoviesState {}

class ClearUserModelState extends MoviesState {}

class MoviesGetMultiSearchLoadingData extends MoviesState {}

class MoviesGetMultiSearchSuccessData extends MoviesState {}

class MoviesGetMultiSearchErrorData extends MoviesState {
  final String? error;

  MoviesGetMultiSearchErrorData({required this.error});
}

class AddToWatchListLoadingState extends MoviesState {}

class AddToWatchListSuccessState extends MoviesState {
  final String mediaType;

  AddToWatchListSuccessState({required this.mediaType});
}

class AddToWatchListErrorState extends MoviesState {
  final String? error;

  AddToWatchListErrorState({required this.error});
}

class GetWatchListLoadingState extends MoviesState {}

class GetWatchListSuccessState extends MoviesState {}

class GetWatchListErrorState extends MoviesState {
  final String? error;

  GetWatchListErrorState({required this.error});
}

class FilterWatchListState extends MoviesState {}

class DeleteWatchListLoadingState extends MoviesState {}

class DeleteWatchListSuccessState extends MoviesState {}

class DeleteWatchListErrorState extends MoviesState {
  final String? error;

  DeleteWatchListErrorState({required this.error});
}

class ChangeWatchListErrorState extends MoviesState {
  final String? error;

  ChangeWatchListErrorState({required this.error});
}

class ChangeWatchListLocalState extends MoviesState {}
