import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static const String _languageKey = 'app_language';
  static const String _themeKey = 'app_theme';
  static const String _userNameKey = 'userName';
  static const String _userEmailKey = 'userEmail';
  static const String _avatarIdKey = 'avatarId';
  static const String _onBoardingKey = 'onBoarding_viewed';

  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> setOnBoardingViewed() async {
    await sharedPreferences.setBool(_onBoardingKey, true);
  }

  static bool isOnBoardingViewed() {
    return sharedPreferences.getBool(_onBoardingKey) ?? false;
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

  static Future<void> saveUserData({
    required String name,
    required String email,
    required int avatarId,
  }) async {
    await sharedPreferences.setString(_userNameKey, name);
    await sharedPreferences.setString(_userEmailKey, email);
    await sharedPreferences.setInt(_avatarIdKey, avatarId);
  }

  static String? getUserName() {
    return sharedPreferences.getString(_userNameKey);
  }

  static String? getUserEmail() {
    return sharedPreferences.getString(_userEmailKey);
  }

  static int? getAvatarId() {
    return sharedPreferences.getInt(_avatarIdKey);
  }

  static Future<void> clearAll() async {
    await sharedPreferences.clear();
  }
}