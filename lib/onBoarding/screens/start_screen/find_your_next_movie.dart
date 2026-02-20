import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import '../../../widgets/app_button.dart';
import '../../../core/image/app_assets.dart';
import '../../widget/onboarding_widget_screen.dart';

class FindYourNextMovie extends StatelessWidget {
  const FindYourNextMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      backgroundImage: AppImages.findYourNextMovie,
      containerColor: AppColors.transparentColor,
      title: "find_your_next_favorite_movie_here".tr(),
      titleFontSize: 36.sp,
      titleTextColor: AppColors.white,
      content: "get_access".tr(),
      contentFontSize: 20.sp,
      buttons: [
        AppButton(
          buttonTitle: "explore_now".tr(),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.discoverMovies);
          },
          backgroundColor: Theme.of(context).cardColor,
        ),
      ],
    );
  }
}