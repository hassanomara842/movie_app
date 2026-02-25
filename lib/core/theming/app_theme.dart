import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.white,
    splashColor: AppColors.primaryBlack,
    cardColor: AppColors.primaryYellow,
    canvasColor: AppColors.white,
    disabledColor: AppColors.darkGrey,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.primaryYellow),
      centerTitle: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryBlack,
    splashColor: AppColors.white,
    cardColor: AppColors.primaryYellow,
    canvasColor: AppColors.darkGrey,
    disabledColor: AppColors.darkGrey,
    scaffoldBackgroundColor: AppColors.primaryBlack,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryBlack,
      iconTheme: IconThemeData(color: AppColors.primaryYellow),
      centerTitle: true,
    ),
  );
}