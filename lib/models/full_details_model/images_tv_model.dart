class ImagesTVModel {
  List<Backdrops>? backdrops;
  int? id;
  List<Logos>? logos;
  List<Posters>? posters;

  ImagesTVModel({this.backdrops, this.id, this.logos, this.posters});

  ImagesTVModel.fromJson(Map<String, dynamic> json) {
    backdrops = (json['backdrops'] as List?)
        ?.map((dynamic e) => Backdrops.fromJson(e as Map<String, dynamic>))
        .toList();
    id = json['id'] as int?;
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
    json['id'] = id;
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
