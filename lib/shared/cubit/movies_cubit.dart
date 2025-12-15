import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hdbox_app/models/watchlist_model.dart';
import '../../models/episode_model.dart';
import '../../models/full_details_model/credits_details_model.dart';
import '../../models/full_details_model/images_details_model.dart';
import '../../models/full_details_model/images_tv_model.dart';
import '../../models/full_details_model/similar_details_model.dart';
import '../../models/full_details_model/similar_details_tv_model.dart';
import '../../models/genres_data_model.dart';
import '../../models/genres_list_model.dart';
import '../../models/movie_detail_model.dart';
import '../../models/multi_search_model.dart';
import '../../models/network_model.dart';
import '../../models/now_playing_model.dart';
import '../../models/onboarding_model.dart';
import '../../models/person_data_model.dart';
import '../../models/popular_model.dart';
import '../../models/search_model.dart';
import '../../models/top_rated_model.dart';
import '../../models/top_search_model.dart';
import '../../models/trending_model.dart';
import '../../models/tv_movies_model.dart';
import '../../models/upcoming_model.dart';
import '../../models/user_model.dart';
import '../../models/video_model.dart';
import '../../modules/categories/categories_screen.dart';
import '../../modules/home/home_screen.dart';
import '../../modules/profile/profile_screen.dart';
import '../../modules/search/search_screen.dart';
import '../components/constants.dart';
import '../network/end_points.dart';
import '../network/remote/dio_helper.dart';
import 'movies_states.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(InitialState());

  static MoviesCubit get(context) => BlocProvider.of(context);
  var pageController = PageController();

  int currentIndex = 0;
  int carousalIndex = 0;
  int indexIteration=0;
  String searchText = '';
  bool isLast = false;

  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CategoriesScreen(),
    ProfileScreen(),
  ];

  List<AppBar> appBars = [
    AppBar(toolbarHeight: 10.0),
    AppBar(backgroundColor: Colors.yellow),

    AppBar(backgroundColor: Colors.purple),
    AppBar(backgroundColor: Colors.green),
  ];

  void changeBottomNavBar(int index) {
    if (index == 3) {
      getUserFromFirebase();
    }
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void changeOnBoardingPage(int index) {
    isLast = (index == slidesData.length - 1);
    emit(ChangeOnBoardingSlidesState());
  }

  Future<void> getAllData() async {
    try {
      await getPopularData();
      await getTopRatedData();
      await getUpComingData();
      await getTopSearch();
      await getNowPlayingData();
      await getTrendingData();
      await getGenresList();
      emit(MoviesLoadedState());
    } catch (error) {
      emit(MoviesErrorState(error: error.toString()));
    }
  }

  //////////////////////////////////Popular Data///////////////////////////////
  PopularModel? popularModel;

  Future<PopularModel?> getPopularData() {
    emit(MoviesGetPopularLoadingData());
    return DioHelper.getData(
          url: POPULAR,
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0', 'page': '1'},
        )
        .then((value) {
          popularModel = PopularModel.fromJson(value.data);
          emit(MoviesGetPopularSuccessData());
          return popularModel;
        })
        .catchError((error) {
          emit(MoviesGetPopularErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Top Rated Data///////////////////////////////
  TopRatedModel? topRatedModel;

  Future<TopRatedModel?> getTopRatedData() {
    emit(MoviesGetTopRatedLoadingData());
    return DioHelper.getData(
          url: TOPRATED,
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0', 'page': '1'},
        )
        .then((value) {
          topRatedModel = TopRatedModel.fromJson(value.data);
          emit(MoviesGetTopRatedSuccessData());
          return topRatedModel;
        })
        .catchError((error) {
          emit(MoviesGetPopularErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////UpComing Data///////////////////////////////
  UpComingModel? upcomingModel;

  Future<UpComingModel?> getUpComingData() {
    emit(MoviesGetUpComingLoadingData());
    return DioHelper.getData(
          url: UPCOMING,
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          upcomingModel = UpComingModel.fromJson(value.data);
          emit(MoviesGetUpComingSuccessData());
          return upcomingModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetUpComingErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Now Playing Data///////////////////////////////

  NowPlayingModel? nowPlayingModel;

  Future<NowPlayingModel?> getNowPlayingData() {
    emit(MoviesGetNowPlayingLoadingData());
    return DioHelper.getData(
          url: NOWPLAYING,
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          nowPlayingModel = NowPlayingModel.fromJson(value.data);
          emit(MoviesGetNowPlayingSuccessData());
          return nowPlayingModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetNowPlayingErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Trending Data///////////////////////////////

  TrendingModel? trendingModel;

  Future<TrendingModel?> getTrendingData() {
    emit(MoviesGetTrendingLoadingData());
    return DioHelper.getData(
          url: TRENDING,
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          trendingModel = TrendingModel.fromJson(value.data);
          emit(MoviesGetTrendingSuccessData());
          return trendingModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetTrendingErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Top Search Data///////////////////////////////

  TopSearchModel? topSearchModel;

  Future<TopSearchModel?> getTopSearch() {
    emit(MoviesGetTopSearchLoadingData());
    return DioHelper.getData(
          url: 'discover/movie',
          query: {
            'api_key': 'a497f504b6673dad3325dbad736632a0',
            'sort_by': 'popularity.desc',
          },
        )
        .then((value) {
          topSearchModel = TopSearchModel.fromJson(value.data);
          emit(MoviesGetTopSearchSuccessData());
          return topSearchModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetTopSearchErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Search Data///////////////////////////////
  //
  // SearchModel? searchModel;
  //
  // void getSearch({required String q}) {
  //   emit(MoviesGetSearchLoadingData());
  //   DioHelper.getData(
  //         url: SEARCH,
  //         query: {'api_key': 'a497f504b6673dad3325dbad736632a0', 'query': q},
  //       )
  //       .then((value) {
  //         searchModel = SearchModel.fromJson(value.data);
  //         emit(MoviesGetSearchSuccessData());
  //       })
  //       .catchError((error) {
  //         print(error);
  //         emit(MoviesGetSearchErrorData(error: error.toString()));
  //       });
  // }

  MultiSearchModel? multiSearchModel;

  void getMultiSearch({required String q}) {
    emit(MoviesGetMultiSearchLoadingData());
    DioHelper.getData(
          url: 'search/multi',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0', 'query': q},
        )
        .then((value) {
          multiSearchModel = MultiSearchModel.fromJson(value.data);
          multiSearchModel!.results.removeWhere(
            (element) => element.mediaType == 'person',
          );

          emit(MoviesGetMultiSearchSuccessData());
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetMultiSearchErrorData(error: error.toString()));
        });
  }

  ////////////////////////////////// Full Details Data///////////////////////////////
  DetailsModel? detailsModel;
  CreditsModel? creditsModel;
  SimilarModel? similarModel;
  ImagesModel? imagesModel;
  SimilarTVModel? similarTVModel;
  ImagesTVModel? imagesTVModel;

  Future<DetailsModel?> getDetailsData({required int id}) {
    detailsModel = null;
    emit(MoviesGetDetailsLoadingData());
    return DioHelper.getData(
          url: 'movie/$id',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          detailsModel = DetailsModel.fromJson(value.data);
          emit(MoviesGetDetailsSuccessData());
          return detailsModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetDetailsErrorData(error: error.toString()));
          return null;
        });
  }

  Future<CreditsModel?> getCreditsData({required int id}) {
    creditsModel = null;
    emit(MoviesGetCreditsLoadingData());
    return DioHelper.getData(
          url: 'movie/$id',
          query: {
            'api_key': 'a497f504b6673dad3325dbad736632a0',
            'append_to_response': 'credits',
          },
        )
        .then((value) {
          creditsModel = CreditsModel.fromJson(value.data);
          emit(MoviesGetCreditsSuccessData());
          return creditsModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetCreditsErrorData(error: error.toString()));
          return null;
        });
  }

  Future<SimilarModel?> getSimilarData({required int id}) {
    similarModel = null;
    emit(MoviesGetSimilarLoadingData());
    return DioHelper.getData(
          url: 'movie/$id',
          query: {
            'api_key': 'a497f504b6673dad3325dbad736632a0',
            'append_to_response': 'similar',
          },
        )
        .then((value) {
          similarModel = SimilarModel.fromJson(value.data);
          emit(MoviesGetSimilarSuccessData());
          return similarModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetSimilarErrorData(error: error.toString()));
          return null;
        });
  }

  Future<SimilarTVModel?> getSimilarTVData({required int id}) {
    similarTVModel = null;
    emit(MoviesGetSimilarTVLoadingData());
    return DioHelper.getData(
          url: 'tv/$id/similar',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          similarTVModel = SimilarTVModel.fromJson(value.data);
          emit(MoviesGetSimilarTVSuccessData());
          return similarTVModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetSimilarTVErrorData(error: error.toString()));
          return null;
        });
  }

  void getImagesData({required int id}) {
    imagesModel = null;
    emit(MoviesGetImagesLoadingData());
    DioHelper.getData(
          url: 'movie/$id',
          query: {
            'api_key': 'a497f504b6673dad3325dbad736632a0',
            'append_to_response': 'images',
          },
        )
        .then((value) {
          imagesModel = ImagesModel.fromJson(value.data);
          emit(MoviesGetImagesSuccessData());
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetImagesErrorData(error: error.toString()));
        });
  }

  Future<ImagesTVModel?> getImagesTVData({required int id}) {
    imagesTVModel = null;
    emit(MoviesGetImagesTVLoadingData());
    return DioHelper.getData(
          url: 'tv/$id/images',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          imagesTVModel = ImagesTVModel.fromJson(value.data);
          emit(MoviesGetImagesTVSuccessData());
          return imagesTVModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetImagesTVErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Person Data///////////////////////////////
  PersonDataModel? personDataModel;

  void getPersonData({required int id}) {
    personDataModel = null;
    emit(MoviesGetPersonLoadingData());
    DioHelper.getData(
          url: 'person/$id/movie_credits',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          personDataModel = PersonDataModel.fromJson(value.data);
          emit(MoviesGetPersonSuccessData());
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetPersonErrorData(error: error.toString()));
        });
  }

  //////////////////////////////////Network Data///////////////////////////////
  NetworkModel? networkModel;

  void getNetworkData({required int id}) {
    networkModel = null;
    emit(MoviesGetNetworkLoadingData());
    DioHelper.getData(
          url: 'discover/tv',
          query: {
            'api_key': 'a497f504b6673dad3325dbad736632a0',
            'with_networks': id,
          },
        )
        .then((value) {
          networkModel = NetworkModel.fromJson(value.data);
          //print(value.data['id']);
          emit(MoviesGetNetworkSuccessData());
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetNetworkErrorData(error: error.toString()));
        });
  }

  //////////////////////////////////TV Movies Data///////////////////////////////
  TVMoviesModel? tvMoviesModel;

  Future<TVMoviesModel?> getTVMoviesData({required int id}) {
    tvMoviesModel = null;
    emit(MoviesGetTvMoviesLoadingData());
    return DioHelper.getData(
          url: 'tv/$id',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          tvMoviesModel = TVMoviesModel.fromJson(value.data);
          emit(MoviesGetTvMoviesSuccessData());
          return tvMoviesModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetTvMoviesErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Episode Data///////////////////////////////
  EpisodeModel? episodeModel;

  void getEpisodeData({required int id, required int seasonNumber}) {
    episodeModel = null;
    emit(MoviesGetEpisodeLoadingData());
    DioHelper.getData(
          url: 'tv/$id/season/$seasonNumber',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          episodeModel = EpisodeModel.fromJson(value.data);
          emit(MoviesGetEpisodeSuccessData());
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetEpisodeErrorData(error: error.toString()));
        });
  }

  //////////////////////////////////Genres List///////////////////////////////
  GenresListModel? genresListModel;

  Future<GenresListModel?> getGenresList() {
    genresListModel = null;
    emit(MoviesGetGenresListLoadingData());
    return DioHelper.getData(
          url: 'genre/movie/list',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          genresListModel = GenresListModel.fromJson(value.data);
          emit(MoviesGetGenresListSuccessData());
          return genresListModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetGenresListErrorData(error: error.toString()));
          return null;
        });
  }

  //////////////////////////////////Genres Data///////////////////////////////
  GenresDataModel? genresDataModel;

  void getGenresData({required int id}) {
    genresDataModel = null;
    emit(MoviesGetGenresDataLoadingData());
    DioHelper.getData(
          url: 'discover/movie',
          query: {
            'api_key': 'a497f504b6673dad3325dbad736632a0',
            'with_genres': '$id',
          },
        )
        .then((value) {
          genresDataModel = GenresDataModel.fromJson(value.data);
          emit(MoviesGetGenresDataSuccessData());
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetGenresDataErrorData(error: error.toString()));
        });
  }

  //////////////////////////////////Videos Movies Trailer Data///////////////////////////////
  VideoModel? videoModel;

  Future<VideoModel?> getVideoMoviesTrailerData({required int id}) {
    videoModel = null;
    emit(MoviesGetVideoMoviesTrailerDataLoadingData());
    return DioHelper.getData(
          url: 'movie/$id/videos',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          videoModel = VideoModel.fromJson(value.data);
          emit(MoviesGetVideoMoviesTrailerDataSuccessData());
          return videoModel;
        })
        .catchError((error) {
          print(error);
          emit(
            MoviesGetVideoMoviesTrailerDataErrorData(error: error.toString()),
          );
          return null;
        });
  }

  //////////////////////////////////Video TV Episode Data///////////////////////////////

  void getVideoTVEpisodeData({
    required int id,
    required int seasonNumber,
    required int episodeNumber,
  }) {
    videoModel = null;
    emit(MoviesGetVideoTVEpisodeLoadingData());
    DioHelper.getData(
          url: 'tv/$id/season/$seasonNumber/episode/$episodeNumber/videos',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          videoModel = VideoModel.fromJson(value.data);
          emit(MoviesGetVideoTVEpisodeSuccessData());
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetVideoTVEpisodeErrorData(error: error.toString()));
        });
  }

  ////////////////////////////////Video TV Data///////////////////////////////

  Future<VideoModel?> getVideoTVData({required int id}) {
    videoModel = null;
    emit(MoviesGetVideoTVLoadingData());
    return DioHelper.getData(
          url: 'tv/$id/videos',
          query: {'api_key': 'a497f504b6673dad3325dbad736632a0'},
        )
        .then((value) {
          videoModel = VideoModel.fromJson(value.data);
          emit(MoviesGetVideoTVSuccessData());
          return videoModel;
        })
        .catchError((error) {
          print(error);
          emit(MoviesGetVideoTVErrorData(error: error.toString()));
          return null;
        });
  }

  ////////////////////////////////Get Users Data///////////////////////////////
  UserModel? userModel;

  Future<void> getUserFromFirebase() async {
    emit(GetUserDataLoadingState());
    if (Constants.uId.isNotEmpty) {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(Constants.uId)
          .get()
          .then((value) {
            userModel = UserModel.fromJson(value.data()!);
            emit(GetUserDataSuccessState());
            print(value.data()!.length);
          })
          .catchError((error) {
            emit(GetUserDataErrorState(error: error.toString()));
            print(error);
          });
    }
  }

  void resetUserModel() {
    userModel = null;
    emit(ResetUserModelState());
  }

  void resetCurrentIndex() {
    currentIndex = 0;
    emit(ResetCurrentIndexState());
  }

  ////////////////////////////////Add to Watchlist ///////////////////////////////
  bool isLoaded = false;
  List<WatchlistModel> watchlist = [];
  List<WatchlistModel> filteredWatchList = [];
  String selectedType = 'movie'; // default
  bool isWatchlistLoading = false;

  Future<void> addToWatchList({
    required int movieId,
    required String mediaType,
    required String name,
    required String posterPath,
    required String backdropPath,
    required String overview,
  }) async {
    emit(AddToWatchListLoadingState());
    isLoaded = false;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.uId)
        .collection('watchlist')
        .doc('${mediaType}_$movieId')
        .set({
          'name': name,
          'overview': overview,
          'movieId': movieId,
          'mediaType': mediaType,
          'posterPath': posterPath,
          'backdropPath': backdropPath,
          'addedAt': FieldValue.serverTimestamp(),
        })
        .then((value) {
          isLoaded = true;
          emit(AddToWatchListSuccessState(mediaType: mediaType));
        })
        .catchError((error) {
          emit(AddToWatchListErrorState(error: error.toString()));
        });
  }

  Future<void> getWatchList() async {
    isWatchlistLoading = true;
    emit(GetWatchListLoadingState());
    watchlist.clear();
    filteredWatchList.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.uId)
        .collection('watchlist')
        .orderBy('addedAt', descending: true)
        .get()
        .then((value) {
          value.docs.forEach((element) {
            watchlist.add(WatchlistModel.fromJson(element.data()));
          });
          filteredWatchListFun(type: selectedType);
          isWatchlistLoading = false;
          emit(GetWatchListSuccessState());
        })
        .catchError((error) {
          isWatchlistLoading = false;
          emit(GetWatchListErrorState(error: error.toString()));
        });
  }

  void filteredWatchListFun({required String type}) {
    selectedType = type;
    filteredWatchList.clear(); // ✅ مهم جدا
    for (var element in watchlist) {
      if (element.mediaType == selectedType) {
        filteredWatchList.add(element);
      }
    }
    emit(FilterWatchListState());
  }

  Future<void> deleteWatchList({
    required String mediaType,
    required int movieId,
  }) async {
    emit(DeleteWatchListLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.uId)
        .collection('watchlist')
        .doc('${mediaType}_$movieId')
        .delete()
        .then((value) {
          getWatchList();
          emit(DeleteWatchListSuccessState());
        })
        .catchError((error) {
          emit(DeleteWatchListErrorState(error: error.toString()));
        });
  }
}
