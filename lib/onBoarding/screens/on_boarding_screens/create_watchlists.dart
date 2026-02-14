import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/rate_review_and_learn.dart';
import '../../../core/image/app_assets.dart';
import '../../widget/onboarding_button.dart';
import '../../widget/onboarding_widget_screen.dart';

class CreateWatchLists extends StatelessWidget {
  const CreateWatchLists({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 8.h,
      backgroundImage: AppImages.createWatchLists,
      containerColor: AppColors.primaryBlack,
      title: "create_watchlists".tr(),
      titleFontSize: 24.sp,
      content: "save_movies_to_your_watchlist".tr(),
      contentFontSize: 20.sp,
      contentTextColor: AppColors.white,
      buttons: [
        OnboardingButton(
          buttonTitle: "next".tr(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RateReviewAndLearn(),
              ),
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
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
