import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/cubit/profile_cubit.dart';
import 'package:movie_app/cubit/profile_states.dart';
import 'package:movie_app/cubit/wishlist_cubit.dart';
import 'package:movie_app/cubit/wishlist_state.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/main_loading_widget.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> avatars = [
      AppAssets.avatar,
      AppAssets.avatar1,
      AppAssets.avatar2,
      AppAssets.avatar3,
      AppAssets.avatar4,
      AppAssets.avatar5,
      AppAssets.avatar6,
      AppAssets.avatar7,
      AppAssets.avatar8,
    ];

    return BlocListener<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.login, (route) => false);
        }
        if (state is ProfileErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      child: BlocBuilder<ProfileCubit, ProfileStates>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const SizedBox(
              height: 200,
              child: MainLoadingWidget(),
            );
          }

          final user = (state is ProfileSuccessState) ? state.user : null;

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
                          backgroundImage: AssetImage(
                            (user != null && user.avaterId > 0 && user.avaterId <= avatars.length)
                                ? avatars[user.avaterId - 1]
                                : AppAssets.avatar,
                          ),
                        ),
                        Text(
                          user?.name ?? "User",
                          style: AppText.boldText(
                              color: Theme.of(context).splashColor,
                              fontSize: 20.sp),
                        ),
                      ],
                    ),
                    BlocBuilder<WishlistCubit, WishlistState>(
                      builder: (context, wishState) {
                        final count = switch (wishState) {
                          WishlistLoaded s => s.count,
                          _ => 0,
                        };
                        return _buildStatItem(
                          Theme.of(context).splashColor,
                          count.toString(),
                          "wish_list".tr(),
                        );
                      },
                    ),
                    _buildStatItem(
                        Theme.of(context).splashColor, "10", "history".tr()),
                  ],
                ),
                Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      flex: 2,
                      child: AppButton(
                          buttonTitle: "edit_profile".tr(),
                          onPressed: () async {
                            await Navigator.pushNamed(
                                context, AppRoutes.updateProfileScreen);
                            if (context.mounted) {
                              context.read<ProfileCubit>().getUserProfile();
                            }
                          },
                          backgroundColor: Theme.of(context).cardColor),
                    ),
                    Expanded(
                      child: AppButton(
                          buttonTitle: "exit".tr(),
                          textColor: AppColors.white,
                          onPressed: () {
                            context.read<ProfileCubit>().logout();
                          },
                          icon: const Icon(Icons.exit_to_app_rounded),
                          backgroundColor: AppColors.errorRed),
                    )
                  ],
                ),
              ],
            ),
          );
        },
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