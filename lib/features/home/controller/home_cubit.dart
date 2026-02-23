import 'package:hdbox_app/core/helpers/app_imports.dart';
import 'package:hdbox_app/core/models/movie_detail_model.dart';
import 'package:hdbox_app/core/models/now_playing_model.dart';
import 'package:hdbox_app/core/models/popular_model.dart';
import 'package:hdbox_app/core/models/top_rated_model.dart';
import 'package:hdbox_app/core/models/trending_model.dart';
import 'package:hdbox_app/core/models/upcoming_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  int indexIteration = 0;

  //todo
  void changeCarousel(int index) {
    indexIteration = index;
    emit(ChangeCarouselState());
  }

  //////////////////////////////////Popular Data///////////////////////////////
  PopularModel? popularModel;

  Future<PopularModel?> getPopularData() {
    emit(MoviesGetPopularLoadingData());
    return DioHelper.getData(
          url: '/movie/popular',
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
          url: 'movie/top_rated',
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
          url: 'movie/upcoming',
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
          url: 'movie/now_playing',
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
          url: 'trending/movie/day',
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

  /////////////////////////////// watchList//////////////////////

  List<WatchlistModel> watchlist = [];
  List<WatchlistModel> filteredWatchList = [];
  String selectedType = 'movie'; // default
  bool isWatchlistLoading = false;

  //todo
  Map<String, bool> watchlistMap = {};

  Future<void> addToWatchList({
    required int movieId,
    required String mediaType,
    required String name,
    required String posterPath,
    required String backdropPath,
    required String overview,
  }) async {
    emit(AddToWatchListLoadingState());
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
    watchlistMap.clear();
    filteredWatchList.clear();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(Constants.uId)
        .collection('watchlist')
        .orderBy('addedAt', descending: true)
        .snapshots()
        .listen((value) {
          watchlist.clear();

          value.docs.forEach((element) {
            final model = WatchlistModel.fromJson(element.data());
            watchlist.add(model);
            //todo
            watchlistMap['${model.mediaType}_${model.movieId}'] = true;
          });
          filteredWatchListFun(type: selectedType);
          isWatchlistLoading = false;
          emit(GetWatchListSuccessState());
        });
  }

  bool isInWatchList({required int movieId, required String mediaType}) {
    final key = '${mediaType}_$movieId';
    return watchlistMap[key] ?? false;
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

  //
  // bool isInWatchList({required int movieId, required String mediaType}) {
  //   final key = '${mediaType}_$movieId';
  //   return watchlistMap[key] ?? false;
  // }

  Future<void> toggleWatchlist({
    required int movieId,
    required String mediaType,
    required String name,
    required String posterPath,
    required String backdropPath,
    required String overview,
  }) async {
    final key = '${mediaType}_$movieId';
    final isInWatchList = watchlistMap[key] == true;

    watchlistMap[key] = !isInWatchList;
    emit(ChangeWatchListLocalState());

    try {
      if (isInWatchList) {
        //  DELETE
        await deleteWatchList(mediaType: mediaType, movieId: movieId);
      } else {
        //  ADD
        await addToWatchList(
          movieId: movieId,
          mediaType: mediaType,
          name: name,
          posterPath: posterPath,
          backdropPath: backdropPath,
          overview: overview,
        );
      }
    } catch (e) {
      // rollback لو حصل error
      watchlistMap[key] = isInWatchList;
      emit(ChangeWatchListErrorState(error: e.toString()));
    }
  }

  DetailsModel? detailsModel;

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
}
