import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/start_watching_now.dart';
import '../../../core/image/app_assets.dart';
import '../../widget/onboarding_button.dart';
import '../../widget/onboarding_widget_screen.dart';

class RateReviewAndLearn extends StatelessWidget {
  const RateReviewAndLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 8,
      backgroundImage: AppImages.rateReviewAndLearn,
      containerColor: AppColors.primaryBlack,
      title: "rate_review_and_learn".tr(),
      titleFontSize: 24,
      content: "share_your_thoughts".tr(),
      contentFontSize: 20,
      contentTextColor: AppColors.white,
      buttons: [
        OnboardingButton(
          buttonTitle: "next".tr(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const StartWatchingNow()),
            );
          },
          backgroundColor: AppColors.primaryYellow,
        ),
        const SizedBox(width: 8),
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
