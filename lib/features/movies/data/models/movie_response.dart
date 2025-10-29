// import 'package:json_annotation/json_annotation.dart';
// import 'movie_model.dart';

// part 'movie_response.g.dart';

// @JsonSerializable(explicitToJson: true)
// class MovieResponse {
//   final int page;

//   @JsonKey(defaultValue: [])
//   final List<MovieModel> results;

//   @JsonKey(name: 'total_pages', defaultValue: 1)
//   final int totalPages;

//   @JsonKey(name: 'total_results', defaultValue: 0)
//   final int totalResults;

//   MovieResponse({
//     required this.page,
//     required this.results,
//     required this.totalPages,
//     required this.totalResults,
//   });

//   factory MovieResponse.fromJson(Map<String, dynamic> json) =>
//       _$MovieResponseFromJson(json);
//   Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
// }

import 'package:json_annotation/json_annotation.dart';
import 'movie_model.dart';

part 'movie_response.g.dart';

@JsonSerializable()
class MovieResponse {
  final int page;
  final List<MovieModel> results; // ✅ your list of movies

  MovieResponse({required this.page, required this.results});

  factory MovieResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);
}
