import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import 'package:movie_app/core/responsive/size_config.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.primaryBlack : Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: isDark ? AppColors.darkGrey : Colors.grey[100],
                child: Column(
                  children: [
                    const ProfileHeader(),
                    TabBar(
                      dividerColor: Colors.transparent,
                      indicatorColor: AppColors.primaryYellow,
                      indicatorWeight: h(3),
                      indicatorPadding: EdgeInsets.symmetric(horizontal: w(16)),
                      labelColor: AppColors.primaryYellow,
                      unselectedLabelColor: isDark ? AppColors.white : AppColors.primaryBlack,
                      labelStyle: AppText.boldText(
                          color: AppColors.primaryYellow, fontSize: 16),
                      unselectedLabelStyle: AppText.mediumText(
                          color: isDark ? AppColors.white : AppColors.primaryBlack, fontSize: 16),
                      tabs: [
                        Tab(
                          icon: const Icon(Icons.list),
                          text: "wish_list".tr(),
                        ),
                        Tab(
                          icon: const Icon(Icons.folder),
                          text: "history".tr(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildEmptyState(context),
                    _buildEmptyState(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildEmptyState(BuildContext context) {
    final bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.emptyStateImage,
            width: w(150),
          ),
          SizedBox(height: h(10)),
          Text(
            "No list yet",
            style: AppText.regularText(
              color: isDark ? AppColors.white : AppColors.primaryBlack,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}