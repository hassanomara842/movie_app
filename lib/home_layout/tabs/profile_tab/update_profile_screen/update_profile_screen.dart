import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/helpers/cache_helper.dart';
import 'package:movie_app/cubit/profile_cubit.dart';
import 'package:movie_app/cubit/profile_states.dart';
import 'package:movie_app/cubit/update_profile_cubit.dart';
import 'package:movie_app/cubit/update_profile_states.dart';
import 'package:movie_app/widgets/build_inputs.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/main_loading_widget.dart';
import '../../../../core/routing/app_routes.dart';
import 'avatar_bottom_sheet.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
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
  late String selectedAvatar;
  final controller = TextEditingController();
  final phoneController = TextEditingController();
  bool obscureText = false;

  @override
  void initState() {
    super.initState();
    _setupInitialData();
  }

  void _setupInitialData() {
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileSuccessState && profileState.user != null) {
      controller.text = profileState.user!.name;
      phoneController.text = profileState.user!.phone;
      int avatarId = profileState.user!.avaterId;
      selectedAvatar = avatars[(avatarId - 1).clamp(0, avatars.length - 1)];
    } else {
      controller.text = CacheHelper.getUserName() ?? "";
      phoneController.text = "";
      int avatarId = CacheHelper.getAvatarId() ?? 1;
      selectedAvatar = avatars[(avatarId - 1).clamp(0, avatars.length - 1)];
    }
  }

  @override
  void dispose() {
    controller.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileCubit, ProfileStates>(
          listener: (context, state) {
            if (state is ProfileSuccessState && state.user != null) {
              setState(() {
                controller.text = state.user!.name;
                phoneController.text = state.user!.phone;
                int avatarId = state.user!.avaterId;
                selectedAvatar = avatars[(avatarId - 1).clamp(0, avatars.length - 1)];
              });
            }
          },
        ),
        BlocListener<UpdateProfileCubit, UpdateProfileStates>(
          listener: (context, state) {
            if (state is UpdateProfileLoadingState || state is DeleteAccountLoadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => const MainLoadingWidget(),
              );
            } else if (state is UpdateProfileSuccessState) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Profile Updated Successfully")),
              );
              Navigator.pop(context);
            } else if (state is DeleteAccountSuccessState) {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.onBoardingScreen, (route) => false);
            } else if (state is UpdateProfileErrorState || state is DeleteAccountErrorState) {
              Navigator.pop(context);
              String errorMsg = "";
              if (state is UpdateProfileErrorState) errorMsg = state.error;
              if (state is DeleteAccountErrorState) errorMsg = state.error;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMsg)),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Theme.of(context).cardColor),
          title: Text(
            'pick_avatar'.tr(),
            style: AppText.boldText(
                color: Theme.of(context).cardColor, fontSize: 16.sp),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: LayoutBuilder(builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      spacing: 20.h,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) => AvatarBottomSheet(
                                  onAvatarSelected: (avatar) {
                                    setState(() {
                                      selectedAvatar = avatar;
                                    });
                                  },
                                  selectedAvatar: selectedAvatar,
                                ),
                              );
                            },
                            child: Container(
                              width: 170.w,
                              height: 160.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(selectedAvatar),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ),
                        BuildInputs(
                          icon: Icons.person,
                          hint: "name".tr(),
                          controller: controller,
                          isPass: false,
                          textInputType: TextInputType.name,
                        ),
                        BuildInputs(
                          icon: Icons.phone,
                          hint: "phone_number".tr(),
                          isPass: false,
                          controller: phoneController,
                          textInputType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(AppRoutes.resetPassword);
                            },
                            child: Text(
                              "reset_password".tr(),
                              style: AppText.regularText(
                                color: Theme.of(context).splashColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        AppButton(
                          buttonTitle: "delete_account".tr(),
                          onPressed: () {
                            context.read<UpdateProfileCubit>().deleteAccount();
                          },
                          backgroundColor: AppColors.errorRed,
                          textColor: AppColors.white,
                        ),
                        AppButton(
                          buttonTitle: "update_data".tr(),
                          onPressed: () {
                            int avatarId = avatars.indexOf(selectedAvatar) + 1;
                            context.read<UpdateProfileCubit>().updateProfile(
                              name: controller.text,
                              phone: phoneController.text,
                              avaterId: avatarId,
                            );
                          },
                          backgroundColor: Theme.of(context).cardColor,
                          textColor: AppColors.primaryBlack,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })),
      ),
    );
  }
}
