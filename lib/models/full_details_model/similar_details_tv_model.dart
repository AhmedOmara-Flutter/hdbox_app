class SimilarTVModel {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  SimilarTVModel({this.page, this.results, this.totalPages, this.totalResults});

  SimilarTVModel.fromJson(Map<String, dynamic> json) {
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
  List<int>? genreIds;
  int? id;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  Results({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.firstAirDate,
    this.name,
    this.voteAverage,
    this.voteCount,
  });

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    genreIds = (json['genre_ids'] as List?)
        ?.map((dynamic e) => e as int)
        .toList();
    id = json['id'] as int?;
    originCountry = (json['origin_country'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    originalLanguage = json['original_language'] as String?;
    originalName = json['original_name'] as String?;
    overview = json['overview'] as String?;
    popularity = json['popularity'] as double?;
    posterPath = json['poster_path'] as String?;
    firstAirDate = json['first_air_date'] as String?;
    name = json['name'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['adult'] = adult;
    json['backdrop_path'] = backdropPath;
    json['genre_ids'] = genreIds;
    json['id'] = id;
    json['origin_country'] = originCountry;
    json['original_language'] = originalLanguage;
    json['original_name'] = originalName;
    json['overview'] = overview;
    json['popularity'] = popularity;
    json['poster_path'] = posterPath;
    json['first_air_date'] = firstAirDate;
    json['name'] = name;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    return json;
  }
}
