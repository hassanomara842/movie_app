import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'language_view_model.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  final viewModel = LanguageViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: viewModel,
      builder: (context, _) {
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
            spacing: 25.w,
            children: [
              GestureDetector(
                onTap: () =>
                    viewModel.changeLanguage(LanguageType.english, context),
                child: languageFlagsWidget(
                  isSelected:
                      viewModel.selectedLanguage == LanguageType.english,
                  image: AppImages.lrImage,
                ),
              ),
              GestureDetector(
                onTap: () =>
                    viewModel.changeLanguage(LanguageType.arabic, context),
                child: languageFlagsWidget(
                  isSelected: viewModel.selectedLanguage == LanguageType.arabic,
                  image: AppImages.egyptImage,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget languageFlagsWidget(
      {required bool isSelected, required String image}) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: isSelected
            ? Border.all(
                color: AppColors.primaryYellow,
                width: 6,
              )
            : null,
      ),
      child: ClipOval(
        child: Image.asset(
          image,
          width: 45.w,
          height: 45.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
