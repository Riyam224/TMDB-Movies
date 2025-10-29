import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';

sealed class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieEntity> movies;
  MovieLoaded(this.movies);
}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}
