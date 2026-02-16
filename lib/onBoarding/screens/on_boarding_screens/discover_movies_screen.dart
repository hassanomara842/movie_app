import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import '../../../core/image/app_assets.dart';
import '../../../widgets/app_button.dart';
import '../../widget/onboarding_widget_screen.dart';

class DiscoverMoviesScreen extends StatelessWidget {
  const DiscoverMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingWidgetScreen(
      spacing: 24.h,
      backgroundImage: AppImages.discoverMovies,
      containerColor: Theme.of(context).primaryColor,
      title: "discover_movies".tr(),
      titleFontSize: 24.sp,
      content: "explore_a_vest".tr(),
      titleTextColor: Theme.of(context).splashColor,
      contentFontSize: 20.sp,
      contentTextColor: Theme.of(context).splashColor,
      buttons: [
        AppButton(
          buttonTitle: "next".tr(),
          onPressed: () {
            Navigator.of(context).pushNamed(AppRoutes.exploreAllGenre);
          },
          backgroundColor: Theme.of(context).cardColor,
        ),
      ],
    );
  }
}
