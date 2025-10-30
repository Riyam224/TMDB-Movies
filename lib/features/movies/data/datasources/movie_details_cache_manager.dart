import 'package:hive/hive.dart';
import 'package:movies_app/features/movies/data/models/movie_details_response.dart';

class MovieDetailsCacheManager {
  static const _boxName = 'movie_details_box';

  /// ✅ Save details for a specific movie
  Future<void> cacheMovieDetails(MovieDetailsResponse movie) async {
    final box = await Hive.openBox<MovieDetailsResponse>(_boxName);
    await box.put(movie.id, movie);
  }

  /// ✅ Get cached details by movie ID
  Future<MovieDetailsResponse?> getCachedMovieDetails(int id) async {
    final box = await Hive.openBox<MovieDetailsResponse>(_boxName);
    return box.get(id);
  }

  /// ✅ Check if this movie is cached
  Future<bool> hasCache(int id) async {
    final box = await Hive.openBox<MovieDetailsResponse>(_boxName);
    return box.containsKey(id);
  }

  /// ✅ Clear all cached data (optional)
  Future<void> clearAll() async {
    final box = await Hive.openBox<MovieDetailsResponse>(_boxName);
    await box.clear();
  }
}
