import 'package:dio/dio.dart';
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:movies_app/features/movies/data/models/movie_details_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movies_app/features/movies/data/models/movie_response.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: MyConstants.baseUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio, {String baseUrl}) = _MovieApiService;

  /// 🎬 Fetch popular movies
  @GET('/movie/popular')
  Future<MovieResponse> getPopularMovies(@Query('page') int page);

  /// 🎥 Fetch movie details by ID
  @GET('/movie/{movie_id}')
  Future<MovieDetailsResponse> getMovieDetails(@Path('movie_id') int movieId);
}
