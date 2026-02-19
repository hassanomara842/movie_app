import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String _languageKey = 'app_language';
  static const String _themeKey = 'app_theme';
  static late SharedPreferences sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
  static String? getLanguage() {
    return sharedPreferences.getString(_languageKey);
  }
  static Future<void> setLanguage(String lang) async {
    await sharedPreferences.setString(_languageKey, lang);
  }
  static ThemeMode getTheme() {
    final theme = sharedPreferences.getString(_themeKey);

    if (theme == 'dark') return ThemeMode.dark;
    if (theme == 'light') return ThemeMode.light;

    return ThemeMode.system;
  }
  static Future<void> setTheme(ThemeMode theme) async {
    await sharedPreferences.setString(_themeKey, theme.name);
  }
  static String get appLocal => getLanguage() ?? "en";
  
  static ThemeMode get appTheme => getTheme();

  static bool isDarkTheme() {
    return getTheme() == ThemeMode.dark;
  }
}
