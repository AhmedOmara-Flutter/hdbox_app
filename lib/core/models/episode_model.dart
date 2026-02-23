class EpisodeModel {
  String? idPath;
  String? airDate;
  List<Episodes>? episodes;
  String? name;
  List<Networks>? networks;
  String? overview;
  int? id;
  String? posterPath;
  int? seasonNumber;
  double? voteAverage;

  EpisodeModel({
    this.id,
    this.airDate,
    this.episodes,
    this.name,
    this.networks,
    this.overview,
    this.idPath,
    this.posterPath,
    this.seasonNumber,
    this.voteAverage,
  });

  EpisodeModel.fromJson(Map<String, dynamic> json) {
    idPath = json['_id'] as String?;
    airDate = json['air_date'] as String?;
    episodes = (json['episodes'] as List?)
        ?.map((dynamic e) => Episodes.fromJson(e as Map<String, dynamic>))
        .toList();
    name = json['name'] as String?;
    networks = (json['networks'] as List?)
        ?.map((dynamic e) => Networks.fromJson(e as Map<String, dynamic>))
        .toList();
    overview = json['overview'] as String?;
    id = json['id'] as int?;
    posterPath = json['poster_path'] as String?;
    seasonNumber = json['season_number'] as int?;
    voteAverage = json['vote_average'] as double?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['_id'] = id;
    json['air_date'] = airDate;
    json['episodes'] = episodes?.map((e) => e.toJson()).toList();
    json['name'] = name;
    json['networks'] = networks?.map((e) => e.toJson()).toList();
    json['overview'] = overview;
    json['id'] = id;
    json['poster_path'] = posterPath;
    json['season_number'] = seasonNumber;
    json['vote_average'] = voteAverage;
    return json;
  }
}

class Episodes {
  String? airDate;
  int? episodeNumber;
  String? episodeType;
  int? id;
  String? name;
  String? overview;
  String? productionCode;
  int? runtime;
  int? seasonNumber;
  int? showId;
  String? stillPath;
  double? voteAverage;
  int? voteCount;
  List<Crew>? crew;
  List<GuestStars>? guestStars;

  Episodes({
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
    this.voteAverage,
    this.voteCount,
    this.crew,
    this.guestStars,
  });

  Episodes.fromJson(Map<String, dynamic> json) {
    airDate = json['air_date'] as String?;
    episodeNumber = json['episode_number'] as int?;
    episodeType = json['episode_type'] as String?;
    id = json['id'] as int?;
    name = json['name'] as String?;
    overview = json['overview'] as String?;
    productionCode = json['production_code'] as String?;
    runtime = json['runtime'] as int?;
    seasonNumber = json['season_number'] as int?;
    showId = json['show_id'] as int?;
    stillPath = json['still_path'] as String?;
    voteAverage = json['vote_average'] as double?;
    voteCount = json['vote_count'] as int?;
    crew = (json['crew'] as List?)
        ?.map((dynamic e) => Crew.fromJson(e as Map<String, dynamic>))
        .toList();
    guestStars = (json['guest_stars'] as List?)
        ?.map((dynamic e) => GuestStars.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['air_date'] = airDate;
    json['episode_number'] = episodeNumber;
    json['episode_type'] = episodeType;
    json['id'] = id;
    json['name'] = name;
    json['overview'] = overview;
    json['production_code'] = productionCode;
    json['runtime'] = runtime;
    json['season_number'] = seasonNumber;
    json['show_id'] = showId;
    json['still_path'] = stillPath;
    json['vote_average'] = voteAverage;
    json['vote_count'] = voteCount;
    json['crew'] = crew?.map((e) => e.toJson()).toList();
    json['guest_stars'] = guestStars?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Crew {
  String? department;
  String? job;
  String? creditId;
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;

  Crew({
    this.department,
    this.job,
    this.creditId,
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
  });

  Crew.fromJson(Map<String, dynamic> json) {
    department = json['department'] as String?;
    job = json['job'] as String?;
    creditId = json['credit_id'] as String?;
    adult = json['adult'] as bool?;
    gender = json['gender'] as int?;
    id = json['id'] as int?;
    knownForDepartment = json['known_for_department'] as String?;
    name = json['name'] as String?;
    originalName = json['original_name'] as String?;
    popularity = json['popularity'] as double?;
    profilePath = json['profile_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['department'] = department;
    json['job'] = job;
    json['credit_id'] = creditId;
    json['adult'] = adult;
    json['gender'] = gender;
    json['id'] = id;
    json['known_for_department'] = knownForDepartment;
    json['name'] = name;
    json['original_name'] = originalName;
    json['popularity'] = popularity;
    json['profile_path'] = profilePath;
    return json;
  }
}

class GuestStars {
  String? character;
  String? creditId;
  int? order;
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;

  GuestStars({
    this.character,
    this.creditId,
    this.order,
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
  });

  GuestStars.fromJson(Map<String, dynamic> json) {
    character = json['character'] as String?;
    creditId = json['credit_id'] as String?;
    order = json['order'] as int?;
    adult = json['adult'] as bool?;
    gender = json['gender'] as int?;
    id = json['id'] as int?;
    knownForDepartment = json['known_for_department'] as String?;
    name = json['name'] as String?;
    originalName = json['original_name'] as String?;
    popularity = json['popularity'] as double?;
    profilePath = json['profile_path'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['character'] = character;
    json['credit_id'] = creditId;
    json['order'] = order;
    json['adult'] = adult;
    json['gender'] = gender;
    json['id'] = id;
    json['known_for_department'] = knownForDepartment;
    json['name'] = name;
    json['original_name'] = originalName;
    json['popularity'] = popularity;
    json['profile_path'] = profilePath;
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
