import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:movie_app/core/colors/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white
=======
import '../colors/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.white,
    splashColor: AppColors.primaryBlack,
    cardColor: AppColors.primaryYellow,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.primaryYellow),
      centerTitle: true,
    ),
>>>>>>> origin/develop
  );

  static final ThemeData darkTheme = ThemeData(
<<<<<<< HEAD
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.primaryBlack
=======
    primaryColor: AppColors.primaryBlack,
    splashColor: AppColors.white,
    cardColor: AppColors.primaryYellow,
    scaffoldBackgroundColor: AppColors.primaryBlack,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlack,
      iconTheme: IconThemeData(color: AppColors.primaryYellow),
      centerTitle: true,
    ),
>>>>>>> origin/develop
  );
}
