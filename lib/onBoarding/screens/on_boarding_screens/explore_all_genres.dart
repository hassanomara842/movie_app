import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import '../../../core/image/app_assets.dart';
import '../../widget/onboarding_button.dart';
import '../../widget/onboarding_widget_screen.dart';
import 'create_watchlists.dart';

class ExploreAllGenres extends StatelessWidget {
  const ExploreAllGenres({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 8.h,
      backgroundImage: AppImages.exploreAllGenres,
      containerColor: AppColors.primaryBlack,
      title: "explore_all_genres".tr(),
      titleFontSize: 24.sp,
      content: "discover_movies_from_every_genre".tr(),
      contentFontSize: 20.sp,
      contentTextColor: AppColors.white,
      buttons: [
        OnboardingButton(
          buttonTitle: "next".tr(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateWatchLists()),
            );
          },
          backgroundColor: AppColors.primaryYellow,
        ),
        SizedBox(height: 8.h),
        OnboardingButton(
          buttonTitle: "back".tr(),
          borderSideColor: AppColors.primaryYellow,
          textColor: AppColors.primaryYellow,
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: AppColors.transparentColor,
        ),
      ],
    );
  }
}
