// import 'dart:ui';
//
// class GenresDataModel {
//   final String genre;
//   final Color color;
//   final int id;
//
//   GenresDataModel(this.color, {required this.genre, required this.id});
// }
//
// final List<GenresDataModel> genresList = [
//   GenresDataModel(Color(0xFFFF5252), genre: "Action", id: 28),
//   GenresDataModel(Color(0xFF64FFDA), genre: "Adventure", id: 12),
//   GenresDataModel(Color(0xFF69F0AE), genre: "Animation", id: 16),
//   GenresDataModel(Color(0xFFFFAB40), genre: "Comedy", id: 35),
//   GenresDataModel(Color(0xFF9E9E9E), genre: "Crime", id: 80),
//   GenresDataModel(Color(0xFF40C4FF), genre: "Documentary", id: 99),
//   GenresDataModel(Color(0xFF448AFF), genre: "Drama", id: 18),
//   GenresDataModel(Color(0xFFB2FF59), genre: "Family", id: 10751),
//   GenresDataModel(Color(0xFFE040FB), genre: "Fantasy", id: 14),
//   GenresDataModel(Color(0xFF795548), genre: "History", id: 36),
//   GenresDataModel(Color(0xFF7C4DFF), genre: "Horror", id: 27),
//   GenresDataModel(Color(0xFFFF4081), genre: "Music", id: 10402),
//   GenresDataModel(Color(0xFF536DFE), genre: "Mystery", id: 9648),
//   GenresDataModel(Color(0xFFFF80AB), genre: "Romance", id: 10749),
//   GenresDataModel(Color(0xFF18FFFF), genre: "Sci-Fi", id: 878),
//   GenresDataModel(Color(0xFFFFD740), genre: "TV Movie", id: 10770),
//   GenresDataModel(Color(0xFFFFFF00), genre: "Thriller", id: 53),
//   GenresDataModel(Color(0xFFFF5252), genre: "War", id: 10752),
//   GenresDataModel(Color(0xFFFF6E40), genre: "Western", id: 37),
// ];
class GenresListModel {
  List<Genres>? genres;

  GenresListModel({this.genres});

  GenresListModel.fromJson(Map<String, dynamic> json) {
    genres = (json['genres'] as List?)
        ?.map((dynamic e) => Genres.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['genres'] = genres?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Genres {
  int? id;
  String? name;

  Genres({this.id, this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    return json;
  }
}
