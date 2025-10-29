import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';

import '../entities/movie_entity.dart';
import '../entities/movie_details_entity.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies({int page = 1});
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(int id);
}
