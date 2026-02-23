import 'package:cloud_firestore/cloud_firestore.dart';

class WatchlistModel {
  int? movieId;
  String? mediaType;
  Timestamp? addedAt;
  String? posterPath;
  String? backdropPath;
  String? overview;
  String ?name;

  WatchlistModel({
    this.movieId,
    this.mediaType,
    this.addedAt,
    this.posterPath,
    this.overview,
    this.name,
    this.backdropPath
  });

  WatchlistModel.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    movieId = json['movieId'];
    addedAt = json['addedAt'];
    posterPath = json['posterPath'];
    overview = json['overview'];
    name = json['name'];
    backdropPath = json['backdropPath'];
  }

  Map<String, dynamic> toMap() {
    return {
      'mediaType': mediaType,
      'movieId': movieId,
      'addedAt': addedAt,
      'posterPath': posterPath,
      'overview': overview,
      'name': name,
      'backdropPath': backdropPath
    };
  }
}
