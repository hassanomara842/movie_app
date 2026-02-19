import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/widgets/build_inputs.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/widgets/app_button.dart';
import '../../core/routing/app_routes.dart';
import 'avatar_bottom_sheet.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  String selectedAvatar = AppImages.avatar;
  final controller = TextEditingController();
  final phoneController = TextEditingController();
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'pick_avatar'.tr(),
          style: AppText.boldText(
              color: Theme.of(context).cardColor, fontSize: 16.sp),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
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
                        hint: "Nour",
                        controller: controller,
                        obscureText: obscureText,
                        textInputType: TextInputType.name,
                      ),
                      BuildInputs(
                        icon: Icons.phone,
                        hint: "0123456789".tr(),
                        obscureText: obscureText,
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.resetPassword);
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
                        onPressed: () {},
                        backgroundColor: AppColors.errorRed,
                        textColor: AppColors.white,
                      ),
                      AppButton(
                        buttonTitle: "update_data".tr(),
                        onPressed: () {},
                        backgroundColor: Theme.of(context).cardColor,
                        textColor: AppColors.primaryBlack,
                      ),
                    ],
                  ),
                ),
              ),
            );
          })),
    );
  }
}
