import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';

enum LanguageType { english, arabic }

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  LanguageType selectedLanguage = LanguageType.english;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: AppColors.primaryYellow,
          width: 3,
        ),
      ),
      child: Row(
        spacing: 50.w,
        children: [
          /// English Flag
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguage = LanguageType.english;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: selectedLanguage == LanguageType.english
                    ? Border.all(
                        color: AppColors.primaryYellow,
                        width: 8,
                      )
                    : null,
              ),
              child: ClipOval(
                child: Image.asset(
                  AppImages.lrImage,
                  width: 45.w,
                  height: 45.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          /// Arabic Flag
          GestureDetector(
            onTap: () {
              setState(() {
                selectedLanguage = LanguageType.arabic;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: selectedLanguage == LanguageType.arabic
                    ? Border.all(
                        color: AppColors.primaryYellow,
                        width: 8,
                      )
                    : null,
              ),
              child: ClipOval(
                child: Image.asset(
                  AppImages.egyptImage,
                  width: 45.w,
                  height: 45.h,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
