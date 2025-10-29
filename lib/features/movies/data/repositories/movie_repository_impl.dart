
import 'package:dartz/dartz.dart';
import 'package:movies_app/core/error/failures.dart';
import 'package:movies_app/features/movies/data/datasources/movie_api_service.dart';
import 'package:movies_app/features/movies/data/datasources/movie_cache_manager.dart';
import 'package:movies_app/features/movies/data/models/movie_details_response.dart';
import 'package:movies_app/features/movies/data/models/movie_model.dart';
import 'package:movies_app/features/movies/domain/entities/movie_entity.dart';
import 'package:movies_app/features/movies/domain/entities/movie_details_entity.dart';
import 'package:movies_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movies_app/features/movies/data/models/movie_response.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieApiService apiService;
  final MovieCacheManager cacheManager;

  MovieRepositoryImpl(this.apiService, this.cacheManager);

  int currentPage = 1;

  /// 🎬 Fetch popular movies with pagination + caching
  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies({
    int page = 1,
  }) async {
    try {
      // 1️⃣ Try to get from cache when requesting first page
      if (page == 1) {
        final cached = await cacheManager.getCachedMovies();
        if (cached.isNotEmpty) {
          print('📦 Loaded ${cached.length} movies from Hive cache');
          return Right(cached.map((e) => e.toEntity()).toList());
        }
      }

      // 2️⃣ Fetch from API using Retrofit
      final MovieResponse response = await apiService.getPopularMovies(page);
      final List<MovieModel> movies = response.results;

      // 3️⃣ Cache first page only
      if (page == 1) {
        await cacheManager.cacheMovies(movies);
      }

      print('🌐 API returned ${movies.length} movies (page $page)');
      return Right(movies.map((e) => e.toEntity()).toList());
    } catch (e) {
      print('❌ Error fetching movies: $e');
      return Left(ServerFailure(e.toString()));
    }
  }

  /// 🎥 Fetch single movie details
  @override
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(int id) async {
    try {
      final MovieDetailsResponse details = await apiService.getMovieDetails(id);
      return Right(details.toEntity());
    } catch (e) {
      print('❌ Error fetching movie details: $e');
      return Left(ServerFailure(e.toString()));
    }
  }
}
