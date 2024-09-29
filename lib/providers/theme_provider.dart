import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppThemeProvider extends ChangeNotifier {
  ThemeMode appTheme = ThemeMode.light;
  late SharedPreferences themePref;

  Future<void> getTheme() async {
    themePref = await SharedPreferences.getInstance();
    if (themePref.getBool('isDark') ?? false) {
      appTheme = ThemeMode.dark;
    } else {
      appTheme = ThemeMode.light;
    }
  }

  void changeTheme(ThemeMode newTheme) {
    if (appTheme == newTheme) {
      return;
    }
    appTheme = newTheme;
    notifyListeners();
    _saveTheme(isDark());
  }

  bool isDark() {
    return appTheme == ThemeMode.dark;
  }

  void _saveTheme(bool isDark) {
    themePref.setBool('isDark', isDark);
  }
}
