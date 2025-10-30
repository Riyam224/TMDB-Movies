import 'package:flutter/material.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/core/routing/generated_routes.dart';
import 'package:movies_app/core/theme/theme_provider.dart';
import 'package:movies_app/features/movies/data/models/movie_model.dart';
import 'package:movies_app/features/movies/data/models/movie_details_response.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ✅ Initialize Hive
  await Hive.initFlutter();
  // ✅ Register adapters (after creating them)
  Hive.registerAdapter(MovieModelAdapter());
  Hive.registerAdapter(MovieDetailsResponseAdapter());
  Hive.registerAdapter(GenreModelAdapter());
  await initServiceLocator();

  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://843b5ec1788004f432e0c65e26ca6913@o4510234878410752.ingest.us.sentry.io/4510273619951616';
      // Adds request headers and IP for users, for more info visit:
      // https://docs.sentry.io/platforms/dart/guides/flutter/data-management/data-collected/
      options.sendDefaultPii = true;
      options.enableLogs = true;
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for tracing.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
      // The sampling rate for profiling is relative to tracesSampleRate
      // Setting to 1.0 will profile 100% of sampled transactions:
      options.profilesSampleRate = 1.0;
      // Configure Session Replay
      options.replay.sessionSampleRate = 0.1;
      options.replay.onErrorSampleRate = 1.0;
    },
    appRunner: () => runApp(
      SentryWidget(
        child: ChangeNotifierProvider(
          create: (_) => sl<ThemeProvider>(), // ✅ from GetIt
          child: const MoviesApp(),
        ),
      ),
    ),
  );
  // TODO: Remove this line after sending the first sample event to sentry.
  // await Sentry.captureException(StateError('This is a sample exception.'));
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
