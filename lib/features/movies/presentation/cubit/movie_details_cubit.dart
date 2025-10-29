import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/movie_repository.dart';
import 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final MovieRepository repository;
  MovieDetailsCubit(this.repository) : super(MovieDetailsInitial());

  Future<void> loadMovieDetails(int id) async {
    emit(MovieDetailsLoading());
    final result = await repository.getMovieDetails(id);
    result.fold(
      (failure) => emit(MovieDetailsError(failure.message)),
      (details) => emit(MovieDetailsLoaded(details)),
    );
  }
}
