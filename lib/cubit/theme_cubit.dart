import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/helpers/cache_helper.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(CacheHelper.getTheme());

  void toggleTheme() {
    if (state == ThemeMode.light) {
      emit(ThemeMode.dark);
      CacheHelper.setTheme(ThemeMode.dark);
    } else {
      emit(ThemeMode.light);
      CacheHelper.setTheme(ThemeMode.light);
    }
  }

  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
    CacheHelper.setTheme(themeMode);
  }
}
