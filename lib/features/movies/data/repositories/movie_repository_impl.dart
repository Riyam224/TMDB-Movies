// import 'package:dartz/dartz.dart';
// import 'package:movies_app/core/error/failures.dart';

// import '../../domain/entities/movie_entity.dart';
// import '../../domain/entities/movie_details_entity.dart';
// import '../../domain/repositories/movie_repository.dart';
// import '../datasources/movie_api_service.dart';

// class MovieRepositoryImpl implements MovieRepository {
//   final MovieApiService api;
//   MovieRepositoryImpl(this.api);

//   @override
//   Future<Either<Failure, List<MovieEntity>>> getPopularMovies({
//     int page = 1,
//   }) async {
//     try {
//       final response = await api.getPopularMovies(page);
//       final movies = response.results.map((e) => e.toEntity()).toList();
//       return Right(movies);
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(int id) async {
//     try {
//       final response = await api.getMovieDetails(id);
//       return Right(response.toEntity());
//     } catch (e) {
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }
// import 'package:dartz/dartz.dart';
// import 'package:movies_app/core/error/failures.dart';
// import 'package:movies_app/features/movies/data/datasources/movie_api_service.dart';
// import 'package:movies_app/features/movies/data/datasources/movie_cache_manager.dart';
// import 'package:movies_app/features/movies/data/models/movie_model.dart';
// import 'package:movies_app/features/movies/data/models/movie_response.dart';

// class MovieRepositoryImpl {
//   final MovieApiService apiService;
//   final MovieCacheManager cacheManager;

//   int currentPage = 1; // ✅ Track current page for pagination

//   MovieRepositoryImpl(this.apiService, this.cacheManager);

//   Future<Either<Failure, List<MovieModel>>> getPopularMovies({
//     bool loadMore = false,
//   }) async {
//     try {
//       // ✅ 1. Load from cache if not paginating (first app start)
//       if (!loadMore) {
//         final cachedMovies = await cacheManager.getCachedMovies();
//         if (cachedMovies.isNotEmpty) {
//           print('📦 Loaded ${cachedMovies.length} movies from cache');
//           return Right(cachedMovies);
//         }
//       }

//       // ✅ 2. Fetch from API — note we pass currentPage (required)
//       final MovieResponse response = await apiService.getPopularMovies(
//         currentPage,
//       );

//       final List<MovieModel> movies = response.results;

//       print('🌐 Fetched ${movies.length} movies from API (page $currentPage)');

//       // ✅ 3. Cache first page only (or extend later for multi-page caching)
//       if (currentPage == 1) {
//         await cacheManager.cacheMovies(movies);
//         print('💾 Cached page 1 movies');
//       }

//       // ✅ 4. Increment page number for next pagination request
//       currentPage++;

//       return Right(movies);
//     } catch (e) {
//       print('❌ MovieRepositoryImpl Error: $e');
//       return Left(ServerFailure(e.toString()));
//     }
//   }
// }

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
