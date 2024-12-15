import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hajat_mobile_app/src/services/locator/get_it.dart';

class ThemeRepository {
  static ThemeRepository get instance => getIt<ThemeRepository>();
  static const _kThemePersistenceKey = 'themeMode';

  saveTheme(ThemeMode themeMode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_kThemePersistenceKey, themeMode.name);
  }

  Future<ThemeMode> loadFromPrefs() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    switch (sharedPreferences.getString(_kThemePersistenceKey)) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }
}
