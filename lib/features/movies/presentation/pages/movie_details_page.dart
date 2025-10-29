// todo
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:movies_app/core/di/service_locator.dart';
import '../cubit/movie_details_cubit.dart';
import '../cubit/movie_details_state.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;
  const MovieDetailsPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieDetailsCubit>()..loadMovieDetails(movieId),
      child: Scaffold(
        appBar: AppBar(title: const Text("Movie Details"), centerTitle: true),
        body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
          builder: (context, state) {
            switch (state) {
              case MovieDetailsInitial():
                return const SizedBox();
              case MovieDetailsLoading():
                return const Center(child: CircularProgressIndicator());
              case MovieDetailsLoaded(details: final movie):
                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "poster_${movie.id}",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CachedNetworkImage(
                            imageUrl:
                                '${MyConstants.imageBaseUrl}${movie.posterPath}',
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade900,
                              height: 220,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade800,
                              height: 220,
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 48,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        movie.title,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 22),
                          const SizedBox(width: 6),
                          Text(
                            movie.voteAverage.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Spacer(),
                          const Icon(Icons.calendar_today_outlined, size: 18),
                          const SizedBox(width: 6),
                          Text(
                            movie.releaseDate,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Overview",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        movie.overview,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.5),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          label: const Text("Add to Favorites"),
                        ),
                      ),
                    ],
                  ),
                );

              /// ✅ Clean friendly message instead of raw Dio error
              case MovieDetailsError(message: final msg):
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.wifi_off,
                        size: 70,
                        color: Colors.orange,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Connection Error 😕",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        msg,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      FilledButton(
                        onPressed: () {
                          context.read<MovieDetailsCubit>().loadMovieDetails(
                            movieId,
                          );
                        },
                        child: const Text("Retry"),
                      ),
                    ],
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
