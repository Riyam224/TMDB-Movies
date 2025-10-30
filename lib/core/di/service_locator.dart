import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/core/network/dio_client.dart';
import 'package:movies_app/core/theme/theme_provider.dart';
import 'package:movies_app/features/movies/data/datasources/movie_api_service.dart';
import 'package:movies_app/features/movies/data/datasources/movie_cache_manager.dart';
import 'package:movies_app/features/movies/data/datasources/movie_details_cache_manager.dart';
import 'package:movies_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movies_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movies_app/features/movies/presentation/cubit/movie_cubit.dart';
import 'package:movies_app/features/movies/presentation/cubit/movie_details_cubit.dart';

final sl = GetIt.instance;

Future<void> initServiceLocator() async {
  // 1️⃣ Core: Dio Client
  sl.registerLazySingleton<Dio>(() => DioClient.createDio());

  // 2️⃣ API Layer
  sl.registerLazySingleton<MovieApiService>(() => MovieApiService(sl<Dio>()));

  // 3️⃣ Cache Manager
  sl.registerLazySingleton<MovieCacheManager>(() => MovieCacheManager());

  sl.registerLazySingleton<MovieDetailsCacheManager>(
    () => MovieDetailsCacheManager(),
  );

  // 4️⃣ Repository (registered via interface)
  sl.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      sl<MovieApiService>(),
      sl<MovieCacheManager>(),
      sl<MovieDetailsCacheManager>(),
    ),
  );

  // 5️⃣ Cubits
  sl.registerFactory(() => MovieCubit(sl<MovieRepository>()));
  sl.registerFactory(() => MovieDetailsCubit(sl<MovieRepository>()));

  // 6️⃣ Theme Provider
  sl.registerLazySingleton<ThemeProvider>(() => ThemeProvider());
}
