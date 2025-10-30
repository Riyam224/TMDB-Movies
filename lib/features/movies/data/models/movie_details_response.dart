import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_details_entity.dart';

part 'movie_details_response.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class MovieDetailsResponse {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String overview;

  @HiveField(3)
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @HiveField(4)
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @HiveField(5)
  @JsonKey(name: 'vote_average', defaultValue: 0.0)
  final double voteAverage;

  @HiveField(6)
  @JsonKey(name: 'release_date', defaultValue: '')
  final String releaseDate;

  @HiveField(7)
  @JsonKey(defaultValue: [])
  final List<GenreModel> genres;

  @HiveField(8)
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

@HiveType(typeId: 3)
@JsonSerializable()
class GenreModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  GenreModel({required this.id, required this.name});

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);
}
