import 'package:hdbox_app/core/helpers/app_imports.dart';
import 'package:hdbox_app/core/models/top_search_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static SearchCubit get(context) => BlocProvider.of(context);
  String searchText = '';

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

  void clearSearchField() {
    searchText = '';
    multiSearchModel = null;
    emit(ClearSearchFieldState());
  }
}
