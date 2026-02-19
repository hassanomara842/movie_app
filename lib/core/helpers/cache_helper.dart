import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String _languageKey = 'app_language';
  static const String _themeKey = 'app_theme';
  static const String _onBoardingKey = 'on_boarding_seen';
  static late SharedPreferences sharedPreferences;
  static late ValueNotifier<ThemeMode> themeNotifier;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    themeNotifier = ValueNotifier(getTheme());
  }

  static String? getLanguage() {
    return sharedPreferences.getString(_languageKey);
  }

  static Future<void> setLanguage(String lang) async {
    await sharedPreferences.setString(_languageKey, lang);
  }

  static ThemeMode getTheme() {
    final saved = sharedPreferences.getString(_themeKey);
    if (saved == ThemeMode.light.name) return ThemeMode.light;
    return ThemeMode.dark; // default dark
  }

  static Future<void> setTheme(ThemeMode theme) async {
    await sharedPreferences.setString(_themeKey, theme.name);
    themeNotifier.value = theme;
  }

  static bool getOnBoardingSeen() {
    return sharedPreferences.getBool(_onBoardingKey) ?? false;
  }

  static Future<void> setOnBoardingSeen(bool seen) async {
    await sharedPreferences.setBool(_onBoardingKey, seen);
  }
  static String get appLocal => getLanguage() ?? "en";
  
  static ThemeMode get appTheme => getTheme();

  static bool isDarkTheme() {
    return getTheme() == ThemeMode.dark;
  }
}
