import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_details_entity.dart';

part 'movie_details_response.g.dart';

@JsonSerializable()
class MovieDetailsResponse {
  final int id;
  final String title;
  final String overview;

  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @JsonKey(name: 'vote_average', defaultValue: 0.0)
  final double voteAverage;

  @JsonKey(name: 'release_date', defaultValue: '')
  final String releaseDate;

  @JsonKey(defaultValue: [])
  final List<GenreModel> genres;

  @JsonKey(defaultValue: 0)
  final int runtime;

  MovieDetailsResponse({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.genres,
    required this.runtime,
  });

  factory MovieDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsResponseToJson(this);

  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath ?? '',
      backdropPath: backdropPath ?? '',
      voteAverage: voteAverage,
      releaseDate: releaseDate,
      runtime: runtime,
      genres: genres.map((g) => g.name).toList(),
    );
  }
}

@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}
