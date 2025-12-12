class MultiSearchModel {
  final int? page;
  final List<SearchResult> results;
  final int? totalPages;
  final int? totalResults;

  MultiSearchModel({
    this.page,
    required this.results,
    this.totalPages,
    this.totalResults,
  });

  factory MultiSearchModel.fromJson(Map<String, dynamic> json) {
    final List<SearchResult> filteredResults =
    (json['results'] as List? ?? [])
        .map((e) => SearchResult.fromJson(e))
    // ❌ نستبعد person
        .where(
          (e) => e.mediaType == MediaType.movie || e.mediaType == MediaType.tv,
    )
        .toList();

    return MultiSearchModel(
      page: json['page'],
      results: filteredResults,
      totalPages: json['total_pages'],
      totalResults: filteredResults.length,
    );
  }
}

// ==========================================================

enum MediaType { movie, tv }

MediaType? mediaTypeFromString(String? value) {
  switch (value) {
    case 'movie':
      return MediaType.movie;
    case 'tv':
      return MediaType.tv;
    default:
      return null;
  }
}

// ==========================================================

class SearchResult {
  final int? id;
  final MediaType? mediaType;

  // Movie
  final String? title;
  final String? originalTitle;
  final String? releaseDate;

  // TV
  final String? name;
  final String? originalName;
  final String? firstAirDate;

  // Common
  final String? overview;
  final String? posterPath;
  final String? backdropPath;
  final String? originalLanguage;
  final List<int>? genreIds;
  final double? popularity;
  final double? voteAverage;
  final int? voteCount;

  SearchResult({
    this.id,
    this.mediaType,
    this.title,
    this.originalTitle,
    this.releaseDate,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.overview,
    this.posterPath,
    this.backdropPath,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.voteAverage,
    this.voteCount,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      mediaType: mediaTypeFromString(json['media_type']),

      // movie
      title: json['title'],
      originalTitle: json['original_title'],
      releaseDate: json['release_date'],

      // tv
      name: json['name'],
      originalName: json['original_name'],
      firstAirDate: json['first_air_date'],

      // common
      overview: json['overview'],
      posterPath: json['poster_path'],
      backdropPath: json['backdrop_path'],
      originalLanguage: json['original_language'],
      genreIds: (json['genre_ids'] as List?)?.cast<int>(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
    );
  }

  // ================= UI Helpers =================

  /// Title موحد للـ Movie و TV
  String get displayTitle => title ?? name ?? 'Untitled';

  /// Date موحد للـ Movie و TV
  String get displayDate => releaseDate ?? firstAirDate ?? 'Unknown';

  bool get isMovie => mediaType == MediaType.movie;
  bool get isTv => mediaType == MediaType.tv;
}
