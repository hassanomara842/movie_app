import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import '../../../core/image/app_assets.dart';
import '../../widget/onboarding_button.dart';
import '../../widget/onboarding_widget_screen.dart';

class StartWatchingNow extends StatelessWidget {
  const StartWatchingNow({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 14,
      backgroundImage: AppImages.startWatchingNow,
      containerColor: AppColors.primaryBlack,
      title: "start_Watching_now".tr(),
      titleFontSize: 24,
      contentFontSize: 20,
      contentTextColor: AppColors.white,
      buttons: [
        const SizedBox(height: 27),
        OnboardingButton(
          buttonTitle: "finish".tr(),
          onPressed: () {},
          backgroundColor: AppColors.primaryYellow,
        ),
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
