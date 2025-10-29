import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/features/movies/presentation/cubit/movie_state.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieCubit extends Cubit<MovieState> {
  final MovieRepository repository;
  MovieCubit(this.repository) : super(MovieInitial());

  int currentPage = 1;
  final List _allMovies = [];

  Future<void> loadMovies({bool loadMore = false}) async {
    // Prevent reloading if already loading
    if (state is MovieLoading) return;

    if (!loadMore) {
      emit(MovieLoading());
      currentPage = 1;
      _allMovies.clear();
    } else {
      currentPage++;
    }

    final result = await repository.getPopularMovies(page: currentPage);

    result.fold((failure) => emit(MovieError(failure.message)), (movies) {
      _allMovies.addAll(movies);
      emit(MovieLoaded(List.from(_allMovies)));
    });
  }
}
