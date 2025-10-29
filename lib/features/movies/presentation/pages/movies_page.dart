// ignore_for_file: unused_local_variable, deprecated_member_use, dead_code, unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/constants/api_constants.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/core/routing/app_routes.dart';
import 'package:movies_app/core/theme/theme_provider.dart';
import 'package:movies_app/core/utils/network_helper.dart';
import 'package:movies_app/features/movies/presentation/cubit/movie_cubit.dart';
import 'package:movies_app/features/movies/presentation/cubit/movie_state.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MovieCubit>()..loadMovies(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.movie_creation_outlined, color: Colors.cyan),
              SizedBox(width: 8),
              Text(
                "Movies",
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            Builder(
              builder: (context) {
                final themeProvider = sl<ThemeProvider>();
                IconData themeIcon;
                if (themeProvider.isLight) {
                  themeIcon = Icons.dark_mode_outlined;
                } else if (themeProvider.isDark) {
                  themeIcon = Icons.color_lens_outlined;
                } else {
                  themeIcon = Icons.light_mode_outlined;
                }
                return IconButton(
                  icon: Icon(themeIcon, color: Colors.cyan),
                  tooltip: 'Change Theme',
                  onPressed: () => themeProvider.toggleTheme(),
                );
              },
            ),
          ],
        ),

        body: BlocBuilder<MovieCubit, MovieState>(
          builder: (context, state) {
            final cubit = context.read<MovieCubit>();

            if (state is MovieLoading && cubit.currentPage == 1) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MovieError) {
              return Center(
                child: Text(
                  "⚠️ ${state.message}",
                  style: const TextStyle(color: Colors.redAccent),
                ),
              );
            }

            if (state is MovieLoaded) {
              final movies = state.movies;
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: movies.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final movie = movies[index];
                        return InkWell(
                          borderRadius: BorderRadius.circular(16),

                          /// ✅ OFFLINE CHECK + ALERT DIALOG
                          onTap: () async {
                            final hasInternet =
                                await NetworkHelper.hasConnection();

                            if (!hasInternet) {
                              if (!context.mounted) return;
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: const Color(0xFFFFE0E0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: const Text(
                                    '⚠️ You’re Offline',
                                    style: TextStyle(
                                      color: Color(0xFF11224E),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  content: const Text(
                                    'Please turn on Wi-Fi or mobile data to view movie details.',
                                    style: TextStyle(color: Color(0xFF11224E)),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: const Text(
                                        'OK',
                                        style: TextStyle(
                                          color: Color(0xFFF4813F),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              if (!context.mounted) return;
                              context.pushNamed(
                                AppRoutes.moviesDetails,
                                pathParameters: {'id': movie.id.toString()},
                              );
                            }
                          },

                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.surfaceVariant,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                /// 🎬 Poster
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: movie.posterPath != null
                                        ? '${MyConstants.imageBaseUrl}${movie.posterPath}'
                                        : 'https://via.placeholder.com/70x100?text=No+Image',
                                    width: 70,
                                    height: 100,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 70,
                                      height: 100,
                                      color: Colors.grey.shade900,
                                      child: const Center(
                                        child: SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                          width: 70,
                                          height: 100,
                                          color: Colors.grey.shade800,
                                          child: const Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey,
                                          ),
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                /// 🎞 Info
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${movie.voteAverage.toStringAsFixed(1)}/10',
                                            style: Theme.of(
                                              context,
                                            ).textTheme.titleMedium,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade500,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          movie.genreNames.isNotEmpty
                                              ? movie.genreNames.first
                                              : "N/A",
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  /// 🔹 Pagination Button
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        onPressed: () => cubit.loadMovies(loadMore: true),
                        child: state is MovieLoading && cubit.currentPage > 1
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                "Load More Movies",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
