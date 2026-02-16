import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import '../../../core/image/app_assets.dart';
import '../../../widgets/app_button.dart';
import '../../widget/onboarding_widget_screen.dart';

class StartWatchingNow extends StatelessWidget {
  const StartWatchingNow({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 24.h,
      backgroundImage: AppImages.startWatchingNow,
      containerColor: Theme.of(context).primaryColor,
      title: "start_Watching_now".tr(),
      titleFontSize: 24.sp,
      titleTextColor: Theme.of(context).splashColor,
      buttons: [
        AppButton(
          buttonTitle: "finish".tr(),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.resetPassword,
              (route) => false,
            );
          },
          backgroundColor: Theme.of(context).cardColor
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
