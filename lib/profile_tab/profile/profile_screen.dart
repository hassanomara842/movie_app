import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Theme.of(context).canvasColor,
              child: Column(
                children: [
                  const ProfileHeader(),
                  TabBar(
                    dividerColor: Colors.transparent,
                    indicatorColor: AppColors.primaryYellow,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: AppColors.primaryYellow,
                    unselectedLabelColor: Theme.of(context).splashColor,
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
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.popcornImage,
            width: 150.w,
          ),
        ],
      ),
    );
  }
}
