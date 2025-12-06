class PersonDataModel {
  List<Cast>? cast;
  List<Crew>? crew;
  int? id;

  PersonDataModel({this.cast, this.crew, this.id});

  PersonDataModel.fromJson(Map<String, dynamic> json) {
    cast = (json['cast'] as List?)
        ?.map((dynamic e) => Cast.fromJson(e as Map<String, dynamic>))
        .toList();
    crew = (json['crew'] as List?)
        ?.map((dynamic e) => Crew.fromJson(e as Map<String, dynamic>))
        .toList();
    id = json['id'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['cast'] = cast?.map((e) => e.toJson()).toList();
    json['crew'] = crew?.map((e) => e.toJson()).toList();
    json['id'] = id;
    return json;
  }
}

class Cast {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? character;
  String? creditId;
  int? order;

  Cast({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.character,
    this.creditId,
    this.order,
  });

  Cast.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    genreIds = (json['genre_ids'] as List?)
        ?.map((dynamic e) => e as int)
        .toList();
    id = json['id'] as int?;
    originalLanguage = json['original_language'] as String?;
    originalTitle = json['original_title'] as String?;
    overview = json['overview'] as String?;
    popularity = json['popularity'] as double?;
    posterPath = json['poster_path'] as String?;
    releaseDate = json['release_date'] as String?;
    title = json['title'] as String?;
    video = json['video'] as bool?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    character = json['character'] as String?;
    creditId = json['credit_id'] as String?;
    order = json['order'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['adult'] = adult;
    json['backdrop_path'] = backdropPath;
    json['genre_ids'] = genreIds;
    json['id'] = id;
    json['original_language'] = originalLanguage;
    json['original_title'] = originalTitle;
    json['overview'] = overview;
    json['popularity'] = popularity;
    json['poster_path'] = posterPath;
    json['release_date'] = releaseDate;
    json['title'] = title;
    json['video'] = video;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['character'] = character;
    json['credit_id'] = creditId;
    json['order'] = order;
    return json;
  }
}

class Crew {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? creditId;
  String? department;
  String? job;

  Crew({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.creditId,
    this.department,
    this.job,
  });

  Crew.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    genreIds = (json['genre_ids'] as List?)
        ?.map((dynamic e) => e as int)
        .toList();
    id = json['id'] as int?;
    originalLanguage = json['original_language'] as String?;
    originalTitle = json['original_title'] as String?;
    overview = json['overview'] as String?;
    popularity = json['popularity'] as double?;
    posterPath = json['poster_path'] as String?;
    releaseDate = json['release_date'] as String?;
    title = json['title'] as String?;
    video = json['video'] as bool?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    creditId = json['credit_id'] as String?;
    department = json['department'] as String?;
    job = json['job'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['adult'] = adult;
    json['backdrop_path'] = backdropPath;
    json['genre_ids'] = genreIds;
    json['id'] = id;
    json['original_language'] = originalLanguage;
    json['original_title'] = originalTitle;
    json['overview'] = overview;
    json['popularity'] = popularity;
    json['poster_path'] = posterPath;
    json['release_date'] = releaseDate;
    json['title'] = title;
    json['video'] = video;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['credit_id'] = creditId;
    json['department'] = department;
    json['job'] = job;
    return json;
  }
}
