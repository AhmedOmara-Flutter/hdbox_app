class ImagesModel {
  bool? adult;
  String? backdropPath;
  dynamic belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;
  Images? images;

  ImagesModel({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.images,
  });

  ImagesModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    belongsToCollection = json['belongs_to_collection'];
    budget = json['budget'] as int?;
    genres = (json['genres'] as List?)
        ?.map((dynamic e) => Genres.fromJson(e as Map<String, dynamic>))
        .toList();
    homepage = json['homepage'] as String?;
    id = json['id'] as int?;
    imdbId = json['imdb_id'] as String?;
    originCountry = (json['origin_country'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    originalLanguage = json['original_language'] as String?;
    originalTitle = json['original_title'] as String?;
    overview = json['overview'] as String?;
    popularity = json['popularity'] as double?;
    posterPath = json['poster_path'] as String?;
    productionCompanies = (json['production_companies'] as List?)
        ?.map(
          (dynamic e) =>
              ProductionCompanies.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    productionCountries = (json['production_countries'] as List?)
        ?.map(
          (dynamic e) =>
              ProductionCountries.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    releaseDate = json['release_date'] as String?;
    revenue = json['revenue'] as int?;
    runtime = json['runtime'] as int?;
    spokenLanguages = (json['spoken_languages'] as List?)
        ?.map(
          (dynamic e) => SpokenLanguages.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    status = json['status'] as String?;
    tagline = json['tagline'] as String?;
    title = json['title'] as String?;
    video = json['video'] as bool?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    images = (json['images'] as Map<String, dynamic>?) != null
        ? Images.fromJson(json['images'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['adult'] = adult;
    json['backdrop_path'] = backdropPath;
    json['belongs_to_collection'] = belongsToCollection;
    json['budget'] = budget;
    json['genres'] = genres?.map((e) => e.toJson()).toList();
    json['homepage'] = homepage;
    json['id'] = id;
    json['imdb_id'] = imdbId;
    json['origin_country'] = originCountry;
    json['original_language'] = originalLanguage;
    json['original_title'] = originalTitle;
    json['overview'] = overview;
    json['popularity'] = popularity;
    json['poster_path'] = posterPath;
    json['production_companies'] = productionCompanies
        ?.map((e) => e.toJson())
        .toList();
    json['production_countries'] = productionCountries
        ?.map((e) => e.toJson())
        .toList();
    json['release_date'] = releaseDate;
    json['revenue'] = revenue;
    json['runtime'] = runtime;
    json['spoken_languages'] = spokenLanguages?.map((e) => e.toJson()).toList();
    json['status'] = status;
    json['tagline'] = tagline;
    json['title'] = title;
    json['video'] = video;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['images'] = images?.toJson();
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

class ProductionCompanies {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompanies.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    logoPath = json['logo_path'] as String?;
    name = json['name'] as String?;
    originCountry = json['origin_country'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['logo_path'] = logoPath;
    json['name'] = name;
    json['origin_country'] = originCountry;
    return json;
  }
}

class ProductionCountries {
  String? iso31661;
  String? name;

  ProductionCountries({this.iso31661, this.name});

  ProductionCountries.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'] as String?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['iso_3166_1'] = iso31661;
    json['name'] = name;
    return json;
  }
}

class SpokenLanguages {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});

  SpokenLanguages.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'] as String?;
    iso6391 = json['iso_639_1'] as String?;
    name = json['name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['english_name'] = englishName;
    json['iso_639_1'] = iso6391;
    json['name'] = name;
    return json;
  }
}

class Images {
  List<Backdrops>? backdrops;
  List<Logos>? logos;
  List<Posters>? posters;

  Images({this.backdrops, this.logos, this.posters});

  Images.fromJson(Map<String, dynamic> json) {
    backdrops = (json['backdrops'] as List?)
        ?.map((dynamic e) => Backdrops.fromJson(e as Map<String, dynamic>))
        .toList();
    logos = (json['logos'] as List?)
        ?.map((dynamic e) => Logos.fromJson(e as Map<String, dynamic>))
        .toList();
    posters = (json['posters'] as List?)
        ?.map((dynamic e) => Posters.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['backdrops'] = backdrops?.map((e) => e.toJson()).toList();
    json['logos'] = logos?.map((e) => e.toJson()).toList();
    json['posters'] = posters?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Backdrops {
  double? aspectRatio;
  int? height;
  dynamic iso31661;
  dynamic iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Backdrops({
    this.aspectRatio,
    this.height,
    this.iso31661,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Backdrops.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'] as double?;
    height = json['height'] as int?;
    iso31661 = json['iso_3166_1'];
    iso6391 = json['iso_639_1'];
    filePath = json['file_path'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    width = json['width'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['aspect_ratio'] = aspectRatio;
    json['height'] = height;
    json['iso_3166_1'] = iso31661;
    json['iso_639_1'] = iso6391;
    json['file_path'] = filePath;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['width'] = width;
    return json;
  }
}

class Logos {
  double? aspectRatio;
  int? height;
  String? iso31661;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Logos({
    this.aspectRatio,
    this.height,
    this.iso31661,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Logos.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'] as double?;
    height = json['height'] as int?;
    iso31661 = json['iso_3166_1'] as String?;
    iso6391 = json['iso_639_1'] as String?;
    filePath = json['file_path'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    width = json['width'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['aspect_ratio'] = aspectRatio;
    json['height'] = height;
    json['iso_3166_1'] = iso31661;
    json['iso_639_1'] = iso6391;
    json['file_path'] = filePath;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['width'] = width;
    return json;
  }
}

class Posters {
  double? aspectRatio;
  int? height;
  String? iso31661;
  String? iso6391;
  String? filePath;
  double? voteAverage;
  int? voteCount;
  int? width;

  Posters({
    this.aspectRatio,
    this.height,
    this.iso31661,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  Posters.fromJson(Map<String, dynamic> json) {
    aspectRatio = json['aspect_ratio'] as double?;
    height = json['height'] as int?;
    iso31661 = json['iso_3166_1'] as String?;
    iso6391 = json['iso_639_1'] as String?;
    filePath = json['file_path'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    width = json['width'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['aspect_ratio'] = aspectRatio;
    json['height'] = height;
    json['iso_3166_1'] = iso31661;
    json['iso_639_1'] = iso6391;
    json['file_path'] = filePath;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['width'] = width;
    return json;
  }
}
