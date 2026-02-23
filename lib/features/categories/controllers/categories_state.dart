part of 'categories_cubit.dart';

@immutable
sealed class CategoriesState {}

final class CategoriesInitial extends CategoriesState {}
class MoviesGetGenresListLoadingData extends CategoriesState {}

class MoviesGetGenresListSuccessData extends CategoriesState {}

class MoviesGetGenresListErrorData extends CategoriesState {
  final String? error;

  MoviesGetGenresListErrorData({required this.error});
}

class MoviesGetGenresDataLoadingData extends CategoriesState {}

class MoviesGetGenresDataSuccessData extends CategoriesState {}

class MoviesGetGenresDataErrorData extends CategoriesState {
  final String? error;

  MoviesGetGenresDataErrorData({required this.error});
}
