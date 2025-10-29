import 'package:flutter/material.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/core/routing/generated_routes.dart';
import 'package:movies_app/core/theme/theme_provider.dart';
import 'package:movies_app/features/movies/data/models/movie_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ✅ Initialize Hive
  await Hive.initFlutter();
  // ✅ Register adapters (after creating them)
  Hive.registerAdapter(MovieModelAdapter()); // ✅ register your Hive model
  await initServiceLocator();

  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = sl<ThemeProvider>(); // ✅ from GetIt

    return AnimatedBuilder(
      animation: themeProvider,
      builder: (context, _) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'TMDB Clean App',
          theme: themeProvider.currentTheme, // ✅ renamed correctly
          routerConfig: RouteGenerator.mainRoutingInOurApp,
        );
      },
    );
  }
}
