import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/image/app_assets.dart';
import '../../../core/routing/app_routes.dart';
import '../../../widgets/app_button.dart';
import '../../widget/onboarding_widget_screen.dart';

class CreateWatchLists extends StatelessWidget {
  const CreateWatchLists({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 16.h,
      backgroundImage: AppImages.createWatchLists,
      containerColor: Theme.of(context).primaryColor,
      title: "create_watchlists".tr(),
      titleFontSize: 24.sp,
      content: "save_movies_to_your_watchlist".tr(),
      contentFontSize: 20.sp,
      contentTextColor: Theme.of(context).splashColor,
      titleTextColor: Theme.of(context).splashColor,
      buttons: [
        AppButton(
          buttonTitle: "next".tr(),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.rateAndReview);
          },
          backgroundColor: Theme.of(context).cardColor,
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
