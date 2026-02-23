import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/models/genres_data_model.dart';
import '../../../core/models/genres_list_model.dart';
import '../../../core/network/remote/dio_helper.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());



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

}
