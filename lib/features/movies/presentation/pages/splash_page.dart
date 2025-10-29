import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movies_app/core/di/service_locator.dart';
import 'package:movies_app/core/routing/app_routes.dart';
import 'package:movies_app/core/theme/theme_provider.dart';
import 'movies_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  final themeProvider = sl<ThemeProvider>();

  int _themeIndex = 0; // 0=light, 1=dark, 2=custom

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    // Auto navigation
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MoviesPage()),
        );
      }
    });
  }

  void _toggleTheme() {
    setState(() {
      _themeIndex = (_themeIndex + 1) % 3;
      if (_themeIndex == 0) {
        themeProvider.setLightTheme();
      } else if (_themeIndex == 1) {
        themeProvider.setDarkTheme();
      } else {
        themeProvider.setCustomTheme();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = themeProvider.currentTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: FadeTransition(
        opacity: _fadeIn,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.movie_creation_outlined,
                color: colorScheme.onBackground,
                size: 90,
              ),
              const SizedBox(height: 20),
              Text(
                "Movies App",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: colorScheme.onBackground,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "by Riyam 🌸",
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onBackground.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),

      // 🌈 FAB for Theme switching
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton.extended(
              heroTag: "theme",
              onPressed: _toggleTheme,
              backgroundColor: colorScheme.primary,
              label: const Text("Change Theme"),
              icon: const Icon(Icons.palette_outlined),
            ),
            FloatingActionButton.extended(
              heroTag: "skip",
              onPressed: () {
                GoRouter.of(context).go(AppRoutes.moviesList);
              },
              backgroundColor: colorScheme.secondary,
              label: const Text("Skip"),
              icon: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
