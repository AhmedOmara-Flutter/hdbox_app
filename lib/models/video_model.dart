class VideoModel {
  int? id;
  List<Results>? results;

  VideoModel({this.id, this.results});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    results = (json['results'] as List?)
        ?.map((dynamic e) => Results.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['results'] = results?.map((e) => e.toJson()).toList();
    return json;
  }
}

class Results {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Results({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  Results.fromJson(Map<String, dynamic> json) {
    iso6391 = json['iso_639_1'] as String?;
    iso31661 = json['iso_3166_1'] as String?;
    name = json['name'] as String?;
    key = json['key'] as String?;
    site = json['site'] as String?;
    size = json['size'] as int?;
    type = json['type'] as String?;
    official = json['official'] as bool?;
    publishedAt = json['published_at'] as String?;
    id = json['id'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['iso_639_1'] = iso6391;
    json['iso_3166_1'] = iso31661;
    json['name'] = name;
    json['key'] = key;
    json['site'] = site;
    json['size'] = size;
    json['type'] = type;
    json['official'] = official;
    json['published_at'] = publishedAt;
    json['id'] = id;
    return json;
  }
}
