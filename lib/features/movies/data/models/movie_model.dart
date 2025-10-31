import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/movie_entity.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class MovieModel extends HiveObject {
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
  @JsonKey(name: 'vote_average', defaultValue: 0.0)
  final double voteAverage;

  @HiveField(5)
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    required this.voteAverage,
    required this.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  /// Computed getter: convert genre IDs → readable names
  List<String> get genreNames {
    final map = {
      28: 'Action',
      12: 'Adventure',
      16: 'Animation',
      35: 'Comedy',
      80: 'Crime',
      99: 'Documentary',
      18: 'Drama',
      10751: 'Family',
      14: 'Fantasy',
      36: 'History',
      27: 'Horror',
      10402: 'Music',
      9648: 'Mystery',
      10749: 'Romance',
      878: 'Sci-Fi',
      10770: 'TV Movie',
      53: 'Thriller',
      10752: 'War',
      37: 'Western',
    };

    return genreIds.map((id) => map[id] ?? 'Unknown').toList();
  }

  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      overview: overview,
      posterPath: posterPath ?? '',
      voteAverage: voteAverage,
      genreIds: genreIds,
    );
  }
}
