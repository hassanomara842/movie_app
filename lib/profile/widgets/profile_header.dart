import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/core/image/app_assets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});
  @override
  Widget build(BuildContext context) {
    final bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final Color textColor = isDark ? AppColors.white : AppColors.primaryBlack;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(20)),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkGrey : Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  CircleAvatar(
                    radius: w(55),
                    backgroundImage: const AssetImage(AppImages.avatar),
                  ),
                  SizedBox(height: h(12)),
                  Text(
                    "John Safwat",
                    style: AppText.boldText(color: textColor, fontSize: 20),
                  ),
                ],
              ),
              _buildStatItem(textColor, "12", "wish_list".tr()),
              _buildStatItem(textColor, "10", "history".tr()),
            ],
          ),
          SizedBox(height: h(25)),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: h(45),
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryYellow,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w(10)),
                      ),
                    ),
                    child: Text(
                      "edit_profile".tr(),
                      style: AppText.semiBoldText(
                          color: AppColors.primaryBlack, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(width: w(15)),
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: h(45),
                  child: ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorRed,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(w(10)),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "exit".tr(),
                          style: AppText.semiBoldText(
                              color: AppColors.white, fontSize: 14),
                        ),
                        SizedBox(width: w(8)),
                        Icon(Icons.logout, color: AppColors.white, size: sp(20)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildStatItem(Color textColor, String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: AppText.boldText(color: textColor, fontSize: 30),
        ),
        Text(
          label,
          style: AppText.semiBoldText(color: textColor, fontSize: 20),
        ),
      ],
    );
  }
}