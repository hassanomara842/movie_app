import 'package:flutter/material.dart';
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
   //remove unused functions

}
