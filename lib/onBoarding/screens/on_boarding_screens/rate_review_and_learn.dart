import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import '../../../core/image/app_assets.dart';
import '../../../widgets/app_button.dart';
import '../../widget/onboarding_widget_screen.dart';

class RateReviewAndLearn extends StatelessWidget {
  const RateReviewAndLearn({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 16.h,
      backgroundImage: AppImages.rateReviewAndLearn,
      containerColor: Theme.of(context).primaryColor,
      title: "rate_review_and_learn".tr(),
      titleFontSize: 24.sp,
      content: "share_your_thoughts".tr(),
      contentFontSize: 20.sp,
      contentTextColor: Theme.of(context).splashColor,
      titleTextColor: Theme.of(context).splashColor,
      buttons: [
        AppButton(
          buttonTitle: "next".tr(),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.startWatchingNow);
          },
          backgroundColor:Theme.of(context).cardColor,
        ),
        AppButton(
          buttonTitle: "back".tr(),
          borderSideColor: Theme.of(context).cardColor,
          textColor: Theme.of(context).cardColor,
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColor: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}
