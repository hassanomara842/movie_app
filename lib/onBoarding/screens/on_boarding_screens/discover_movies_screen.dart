import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import '../../../core/image/app_assets.dart';
import '../../widget/onboarding_button.dart';
import '../../widget/onboarding_widget_screen.dart';
import 'explore_all_genres.dart';

class DiscoverMoviesScreen extends StatelessWidget {
  const DiscoverMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 24.h,
      backgroundImage: AppImages.discoverMovies,
      containerColor: AppColors.primaryBlack,
      title: "discover_movies".tr(),
      titleFontSize: 24.sp,
      content: "explore_a_vest".tr(),
      contentFontSize: 20.sp,
      contentTextColor: AppColors.white,
      buttons: [
        OnboardingButton(
          buttonTitle: "next".tr(),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ExploreAllGenres()),
            );
          },
          backgroundColor: AppColors.primaryYellow,
        ),
      ],
    );
  }
}
