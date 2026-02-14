import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import '../../../core/image/app_assets.dart';
import '../../widget/onboarding_button.dart';
import '../../widget/onboarding_widget_screen.dart';
import '../on_boarding_screens/discover_movies_screen.dart';

class FindYourNextMovie extends StatelessWidget {
  const FindYourNextMovie({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      backgroundImage: AppImages.findYourNextMovie,
      containerColor: AppColors.transparentColor,
      title: "find_your_next_favorite_movie_here".tr(),
      titleFontSize: 36.sp,
      content: "get_access".tr(),
      contentFontSize: 20.sp,
      buttons: [
        OnboardingButton(
          buttonTitle: "explore_now".tr(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DiscoverMoviesScreen(),
              ),
            );
          },
          backgroundColor: AppColors.primaryYellow,
        ),
      ],
    );
  }
}
