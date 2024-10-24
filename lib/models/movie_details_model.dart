class MovieDetails {
  final bool adult;
  final String? backdropPath; // Nullable
  final int budget;
  final List<Genre> genres;
  final String? homepage; // Nullable
  final int id;
  final String? imdbId; // Nullable
  final List<String> originCountry;
  final String originalLanguage;
  final String originalTitle;
  final String? overview; // Nullable
  final double popularity;
  final String? posterPath; // Nullable
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String? releaseDate; // Nullable
  final int revenue;
  final int? runtime; // Nullable
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String? tagline; // Nullable
  final String title;
  final double voteAverage;
  final int voteCount;

  MovieDetails({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    this.homepage,
    required this.id,
    this.imdbId,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalTitle,
    this.overview,
    required this.popularity,
    this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    this.releaseDate,
    required this.revenue,
    this.runtime,
    required this.spokenLanguages,
    required this.status,
    this.tagline,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    var genresList = json['genres'] as List? ?? [];
    var productionCompaniesList = json['production_companies'] as List? ?? [];
    var productionCountriesList = json['production_countries'] as List? ?? [];
    var spokenLanguagesList = json['spoken_languages'] as List? ?? [];

    return MovieDetails(
      adult: json['adult'] ?? false, // Default to false if null
      backdropPath: json['backdrop_path'], // Can be null
      budget: json['budget'] ?? 0, // Default to 0 if null
      genres: genresList.map((i) => Genre.fromJson(i)).toList(),
      homepage: json['homepage'], // Can be null
      id: json['id'] ?? 0, // Default to 0 if null
      imdbId: json['imdb_id'], // Can be null
      originCountry: List<String>.from(json['origin_country'] ?? []),
      originalLanguage: json['original_language'] ?? '', // Default to empty string if null
      originalTitle: json['original_title'] ?? '', // Default to empty string if null
      overview: json['overview'], // Can be null
      popularity: json['popularity']?.toDouble() ?? 0.0, // Default to 0.0 if null
      posterPath: json['poster_path'], // Can be null
      productionCompanies: productionCompaniesList
          .map((i) => ProductionCompany.fromJson(i))
          .toList(),
      productionCountries: productionCountriesList
          .map((i) => ProductionCountry.fromJson(i))
          .toList(),
      releaseDate: json['release_date'], // Can be null
      revenue: json['revenue'] ?? 0, // Default to 0 if null
      runtime: json['runtime'], // Can be null
      spokenLanguages: spokenLanguagesList
          .map((i) => SpokenLanguage.fromJson(i))
          .toList(),
      status: json['status'] ?? '', // Default to empty string if null
      tagline: json['tagline'], // Can be null
      title: json['title'] ?? '', // Default to empty string if null
      voteAverage: json['vote_average']?.toDouble() ?? 0.0, // Default to 0.0 if null
      voteCount: json['vote_count'] ?? 0, // Default to 0 if null
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0, // Default to 0 if null
      name: json['name'] ?? '', // Default to empty string if null
    );
  }
}

class ProductionCompany {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath = '', // Default to empty string if null
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0, // Default to 0 if null
      logoPath: json['logo_path'] ?? '', // Default to empty string if null
      name: json['name'] ?? '', // Default to empty string if null
      originCountry: json['origin_country'] ?? '', // Default to empty string if null
    );
  }
}

class ProductionCountry {
  final String iso3166_1;
  final String name;

  ProductionCountry({required this.iso3166_1, required this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso3166_1: json['iso_3166_1'] ?? '', // Default to empty string if null
      name: json['name'] ?? '', // Default to empty string if null
    );
  }
}

class SpokenLanguage {
  final String englishName;
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] ?? '', // Default to empty string if null
      iso6391: json['iso_639_1'] ?? '', // Default to empty string if null
      name: json['name'] ?? '', // Default to empty string if null
    );
  }
}
