// ______________ go router ______________

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/routing/app_routes.dart';
import 'package:movies_app/features/movies/presentation/pages/movie_details_page.dart';
import 'package:movies_app/features/movies/presentation/pages/movies_page.dart';
import 'package:movies_app/features/movies/presentation/pages/splash_page.dart';

class RouteGenerator {
  static GoRouter mainRoutingInOurApp = GoRouter(
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('404 Not Found'))),
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.moviesList,
        name: AppRoutes.moviesList,
        builder: (context, state) => const MoviesPage(),
      ),

      GoRoute(
        path: '${AppRoutes.moviesDetails}/:id',
        name: AppRoutes.moviesDetails,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return MovieDetailsPage(movieId: id);
        },
      ),
    ],
  );
}
