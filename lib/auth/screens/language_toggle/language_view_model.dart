import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/helpers/cache_helper.dart';

enum LanguageType { english, arabic }

class LanguageViewModel extends ChangeNotifier {
  LanguageType selectedLanguage = LanguageType.english;

  void init() {
    final lang = CacheHelper.getLanguage();

    if (lang == "ar") {
      selectedLanguage = LanguageType.arabic;
    } else {
      selectedLanguage = LanguageType.english;
    }
  }

  Future<void> changeLanguage(
      LanguageType type, BuildContext context) async {
    selectedLanguage = type;

    if (type == LanguageType.english) {
      await CacheHelper.setLanguage("en");
      await context.setLocale(const Locale("en"));
    } else {
      await CacheHelper.setLanguage("ar");
      await context.setLocale(const Locale("ar"));
    }

    notifyListeners();
  }
}
