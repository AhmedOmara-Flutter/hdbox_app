import 'package:cloud_firestore/cloud_firestore.dart';

class WatchlistModel {
  int? movieId;
  String? mediaType;
  Timestamp? addedAt;
  String? image;

  WatchlistModel({this.movieId, this.mediaType, this.addedAt, this.image});

  WatchlistModel.fromJson(Map<String, dynamic> json) {
    mediaType = json['mediaType'];
    movieId = json['movieId'];
    addedAt = json['addedAt'];
    image = json['image'];
  }

  Map<String, dynamic> toMap() {
    return {
      'mediaType': mediaType,
      'movieId': movieId,
      'addedAt': addedAt,
      'image': image,
    };
  }
}
