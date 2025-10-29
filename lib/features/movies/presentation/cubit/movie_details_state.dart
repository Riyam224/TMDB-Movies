import 'package:movies_app/features/movies/domain/entities/movie_details_entity.dart';

sealed class MovieDetailsState {}

final class MovieDetailsInitial extends MovieDetailsState {}

final class MovieDetailsLoading extends MovieDetailsState {}

final class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailsEntity details;
  MovieDetailsLoaded(this.details);
}

final class MovieDetailsError extends MovieDetailsState {
  final String message;
  MovieDetailsError(this.message);
}
