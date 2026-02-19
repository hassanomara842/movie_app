import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/widgets/app_button.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 50.h),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      child: Column(
        spacing: 30.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                spacing: 5.h,
                children: [
                  CircleAvatar(
                    radius: 55.w,
                    backgroundImage: const AssetImage(AppImages.avatar3),
                  ),
                  Text(
                    "Nour",
                    style: AppText.boldText(
                        color: Theme.of(context).splashColor, fontSize: 20.sp),
                  ),
                ],
              ),
              _buildStatItem(Theme.of(context).splashColor, "12", "wish_list".tr()),
              _buildStatItem(Theme.of(context).splashColor, "10", "history".tr()),
            ],
          ),
          Row(
            spacing: 10.w,
            children: [
              Expanded(
                flex: 2,
                child: AppButton(
                    buttonTitle: "edit_profile".tr(),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.updateProfileScreen);
                    },
                    backgroundColor: Theme.of(context).cardColor),
              ),
              Expanded(
                child: AppButton(
                    buttonTitle: "exit".tr(),
                    textColor: AppColors.white,
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context,
                          AppRoutes.onBoardingScreen, (route) => false);
                    },
                    icon: Icons.exit_to_app_rounded,
                    isIcon: true,
                    backgroundColor: AppColors.errorRed),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(Color textColor, String count, String label) {
    return Column(
      spacing: 5.h,
      children: [
        Text(
          count,
          style: AppText.boldText(color: textColor, fontSize: 36.sp),
        ),
        Text(
          label,
          style: AppText.semiBoldText(color: textColor, fontSize: 24.sp),
        ),
      ],
    );
  }
}
