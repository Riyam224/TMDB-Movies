import 'package:flutter/material.dart';
import 'app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  /// 🌞 Default to light theme
  ThemeData _themeData = AppTheme.lightTheme;

  ThemeData get currentTheme => _themeData;

  /// 🧠 Helper to know which theme is active
  bool get isLight => _themeData == AppTheme.lightTheme;
  bool get isDark => _themeData == AppTheme.darkTheme;
  bool get isCustom => _themeData == AppTheme.customTheme;

  /// ☀️ Switch to Light Theme
  void setLightTheme() {
    _themeData = AppTheme.lightTheme;
    notifyListeners();
  }

  /// 🌙 Switch to Dark Theme
  void setDarkTheme() {
    _themeData = AppTheme.darkTheme;
    notifyListeners();
  }

  /// 🌸 Switch to Custom Pastel Theme
  void setCustomTheme() {
    _themeData = AppTheme.customTheme;
    notifyListeners();
  }

  /// 🔄 Cycle through all 3 themes (for FAB toggle)
  void toggleTheme() {
    if (isLight) {
      setDarkTheme();
    } else if (isDark) {
      setCustomTheme();
    } else {
      setLightTheme();
    }
  }
}
