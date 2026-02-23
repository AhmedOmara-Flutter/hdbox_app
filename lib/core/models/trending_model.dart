class TrendingModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  TrendingModel({this.page, this.results, this.totalPages, this.totalResults});

  TrendingModel.fromJson(Map<String, dynamic> json) {
    page = json['page'] as int?;
    results = (json['results'] as List?)
        ?.map((dynamic e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
    totalPages = json['total_pages'] as int?;
    totalResults = json['total_results'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['page'] = page;
    json['results'] = results?.map((e) => e.toJson()).toList();
    json['total_pages'] = totalPages;
    json['total_results'] = totalResults;
    return json;
  }
}

class Results {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  Results({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    id = json['id'] as int?;
    title = json['title'] as String?;
    originalTitle = json['original_title'] as String?;
    overview = json['overview'] as String?;
    posterPath = json['poster_path'] as String?;
    mediaType = json['media_type'] as String?;
    originalLanguage = json['original_language'] as String?;
    genreIds = (json['genre_ids'] as List?)
        ?.map((dynamic e) => e as int)
        .toList();
    popularity = json['popularity'] as double?;
    releaseDate = json['release_date'] as String?;
    video = json['video'] as bool?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['adult'] = adult;
    json['backdrop_path'] = backdropPath;
    json['id'] = id;
    json['title'] = title;
    json['original_title'] = originalTitle;
    json['overview'] = overview;
    json['poster_path'] = posterPath;
    json['media_type'] = mediaType;
    json['original_language'] = originalLanguage;
    json['genre_ids'] = genreIds;
    json['popularity'] = popularity;
    json['release_date'] = releaseDate;
    json['video'] = video;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    return json;
  }
}
