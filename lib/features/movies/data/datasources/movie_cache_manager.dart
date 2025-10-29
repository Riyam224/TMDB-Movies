import 'package:hive/hive.dart';
import '../models/movie_model.dart';

class MovieCacheManager {
  static const _boxName = 'moviesBox';

  Future<void> cacheMovies(List<MovieModel> movies) async {
    final box = await Hive.openBox<MovieModel>(_boxName);
    await box.clear(); // Replace old data
    await box.addAll(movies);
  }

  Future<List<MovieModel>> getCachedMovies() async {
    final box = await Hive.openBox<MovieModel>(_boxName);
    return box.values.toList();
  }

  Future<bool> hasCache() async {
    final box = await Hive.openBox<MovieModel>(_boxName);
    return box.isNotEmpty;
  }

  Future<void> clearCache() async {
    final box = await Hive.openBox<MovieModel>(_boxName);
    await box.clear();
  }
}
