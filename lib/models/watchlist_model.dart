import 'package:cloud_firestore/cloud_firestore.dart';

class WatchlistModel {
  int? movieId;
  String? mediaType;
  Timestamp? addedAt;
  String? image;
  String? overview;
  String ?name;

  WatchlistModel({
    this.movieId,
    this.mediaType,
    this.addedAt,
    this.image,
    this.overview,
    this.name
  });

  WatchlistModel.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    movieId = json['movieId'];
    addedAt = json['addedAt'];
    image = json['image'];
    overview = json['overview'];
    name = json['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'mediaType': mediaType,
      'movieId': movieId,
      'addedAt': addedAt,
      'image': image,
      'overview': overview,
      'name': name,
    };
  }
}
