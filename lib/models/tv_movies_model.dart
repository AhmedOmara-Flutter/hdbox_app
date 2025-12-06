class TVMoviesModel {
  bool? adult;
  String? backdropPath;
  List<CreatedBy>? createdBy;
  List<dynamic>? episodeRunTime;
  String? firstAirDate;
  List<Genres>? genres;
  String? homepage;
  int? id;
  bool? inProduction;
  List<String>? languages;
  String? lastAirDate;
  LastEpisodeToAir? lastEpisodeToAir;
  String? name;
  NextEpisodeToAir? nextEpisodeToAir;
  List<Networks>? networks;
  int? numberOfEpisodes;
  int? numberOfSeasons;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  List<Seasons>? seasons;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? type;
  double? voteAverage;
  int? voteCount;

  TVMoviesModel({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  TVMoviesModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] as bool?;
    backdropPath = json['backdrop_path'] as String?;
    createdBy = (json['created_by'] as List?)
        ?.map((dynamic e) => CreatedBy.fromJson(e as Map<String, dynamic>))
        .toList();
    episodeRunTime = json['episode_run_time'] as List?;
    firstAirDate = json['first_air_date'] as String?;
    genres = (json['genres'] as List?)
        ?.map((dynamic e) => Genres.fromJson(e as Map<String, dynamic>))
        .toList();
    homepage = json['homepage'] as String?;
    id = json['id'] as int?;
    inProduction = json['in_production'] as bool?;
    languages = (json['languages'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    lastAirDate = json['last_air_date'] as String?;
    lastEpisodeToAir =
        (json['last_episode_to_air'] as Map<String, dynamic>?) != null
        ? LastEpisodeToAir.fromJson(
            json['last_episode_to_air'] as Map<String, dynamic>,
          )
        : null;
    name = json['name'] as String?;
    nextEpisodeToAir =
        (json['next_episode_to_air'] as Map<String, dynamic>?) != null
        ? NextEpisodeToAir.fromJson(
            json['next_episode_to_air'] as Map<String, dynamic>,
          )
        : null;
    networks = (json['networks'] as List?)
        ?.map((dynamic e) => Networks.fromJson(e as Map<String, dynamic>))
        .toList();
    numberOfEpisodes = json['number_of_episodes'] as int?;
    numberOfSeasons = json['number_of_seasons'] as int?;
    originCountry = (json['origin_country'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    originalLanguage = json['original_language'] as String?;
    originalName = json['original_name'] as String?;
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
    seasons = (json['seasons'] as List?)
        ?.map((dynamic e) => Seasons.fromJson(e as Map<String, dynamic>))
        .toList();
    spokenLanguages = (json['spoken_languages'] as List?)
        ?.map(
          (dynamic e) => SpokenLanguages.fromJson(e as Map<String, dynamic>),
        )
        .toList();
    status = json['status'] as String?;
    tagline = json['tagline'] as String?;
    type = json['type'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['adult'] = adult;
    json['backdrop_path'] = backdropPath;
    json['created_by'] = createdBy?.map((e) => e.toJson()).toList();
    json['episode_run_time'] = episodeRunTime;
    json['first_air_date'] = firstAirDate;
    json['genres'] = genres?.map((e) => e.toJson()).toList();
    json['homepage'] = homepage;
    json['id'] = id;
    json['in_production'] = inProduction;
    json['languages'] = languages;
    json['last_air_date'] = lastAirDate;
    json['last_episode_to_air'] = lastEpisodeToAir?.toJson();
    json['name'] = name;
    json['next_episode_to_air'] = nextEpisodeToAir?.toJson();
    json['networks'] = networks?.map((e) => e.toJson()).toList();
    json['number_of_episodes'] = numberOfEpisodes;
    json['number_of_seasons'] = numberOfSeasons;
    json['origin_country'] = originCountry;
    json['original_language'] = originalLanguage;
    json['original_name'] = originalName;
    json['overview'] = overview;
    json['popularity'] = popularity;
    json['poster_path'] = posterPath;
    json['production_companies'] = productionCompanies
        ?.map((e) => e.toJson())
        .toList();
    json['production_countries'] = productionCountries
        ?.map((e) => e.toJson())
        .toList();
    json['seasons'] = seasons?.map((e) => e.toJson()).toList();
    json['spoken_languages'] = spokenLanguages?.map((e) => e.toJson()).toList();
    json['status'] = status;
    json['tagline'] = tagline;
    json['type'] = type;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    return json;
  }
}

class CreatedBy {
  int? id;
  String? creditId;
  String? name;
  String? originalName;
  int? gender;
  String? profilePath;

  CreatedBy({
    this.id,
    this.creditId,
    this.name,
    this.originalName,
    this.gender,
    this.profilePath,
  });

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    creditId = json['credit_id'] as String?;
    name = json['name'] as String?;
    originalName = json['original_name'] as String?;
    gender = json['gender'] as int?;
    profilePath = json['profile_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['credit_id'] = creditId;
    json['name'] = name;
    json['original_name'] = originalName;
    json['gender'] = gender;
    json['profile_path'] = profilePath;
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

class LastEpisodeToAir {
  int? id;
  String? name;
  String? overview;
  double? voteAverage;
  int? voteCount;
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  LastEpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  LastEpisodeToAir.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    overview = json['overview'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    airDate = json['air_date'] as String?;
    episodeNumber = json['episode_number'] as int?;
    episodeType = json['episode_type'] as String?;
    productionCode = json['production_code'] as String?;
    runtime = json['runtime'] as int?;
    seasonNumber = json['season_number'] as int?;
    showId = json['show_id'] as int?;
    stillPath = json['still_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['overview'] = overview;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['air_date'] = airDate;
    json['episode_number'] = episodeNumber;
    json['episode_type'] = episodeType;
    json['production_code'] = productionCode;
    json['runtime'] = runtime;
    json['season_number'] = seasonNumber;
    json['show_id'] = showId;
    json['still_path'] = stillPath;
    return json;
  }
}

class NextEpisodeToAir {
  int? id;
  String? name;
  String? overview;
  double? voteAverage;
  int? voteCount;
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;

  NextEpisodeToAir({
    this.id,
    this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  NextEpisodeToAir.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    name = json['name'] as String?;
    overview = json['overview'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    airDate = json['air_date'] as String?;
    episodeNumber = json['episode_number'] as int?;
    episodeType = json['episode_type'] as String?;
    productionCode = json['production_code'] as String?;
    runtime = json['runtime'] as int?;
    seasonNumber = json['season_number'] as int?;
    showId = json['show_id'] as int?;
    stillPath = json['still_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['name'] = name;
    json['overview'] = overview;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['air_date'] = airDate;
    json['episode_number'] = episodeNumber;
    json['episode_type'] = episodeType;
    json['production_code'] = productionCode;
    json['runtime'] = runtime;
    json['season_number'] = seasonNumber;
    json['show_id'] = showId;
    json['still_path'] = stillPath;
    return json;
  }
}

class Networks {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  Networks({this.id, this.logoPath, this.name, this.originCountry});

  Networks.fromJson(Map<String, dynamic> json) {
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

class Seasons {
  String? airDate;
  int? episodeCount;
  int? id;
  String? name;
  String? overview;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  Seasons({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  Seasons.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'] as String?;
    episodeCount = json['episode_count'] as int?;
    id = json['id'] as int?;
    name = json['name'] as String?;
    overview = json['overview'] as String?;
    posterPath = json['poster_path'] as String?;
    seasonNumber = json['season_number'] as int?;
    voteAverage = json['vote_average'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['air_date'] = airDate;
    json['episode_count'] = episodeCount;
    json['id'] = id;
    json['name'] = name;
    json['overview'] = overview;
    json['poster_path'] = posterPath;
    json['season_number'] = seasonNumber;
    json['vote_average'] = voteAverage;
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
