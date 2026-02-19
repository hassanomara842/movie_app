import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';

import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/text/app_text.dart';

import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bgColor = theme.scaffoldBackgroundColor;
    final textColor = theme.splashColor;
    final accentColor = theme.cardColor;
    final iconColor = textColor;
    final dividerColor = isDark ? Colors.white24 : Colors.black12;


    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50.h),

                // Logo
                Center(
                  child: SizedBox(
                    width: 140.w,
                    height: 140.w,
                    child: Image.asset(
                      AppImages.appLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 48.h),

                //Email Field
                CustomTextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'email'.tr(),
                  prefixIcon: _buildIconBadge(Icons.email_rounded),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_email'.tr();
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'please_enter_valid_email'.tr();
                    }
                    return null;
                  },
                ),

                SizedBox(height: 16.h),

                //Password Field
                CustomTextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  hintText: 'password'.tr(),
                  prefixIcon: _buildIconBadge(Icons.lock_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: iconColor.withValues(alpha: 0.6),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please_enter_password'.tr();
                    }
                    if (value.length < 6) {
                      return 'password_too_short'.tr();
                    }
                    return null;
                  },
                ),

                // Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.resetPassword);
                    },
                    child: Text(
                      'forget_password_question'.tr(),
                      style: AppText.mediumText(
                        color: accentColor,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                //Login Button
                AppButton(
                  buttonTitle: 'login'.tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.home, (route) => false);
                    }
                  },
                  backgroundColor: accentColor,
                  textColor: AppColors.primaryBlack,
                ),

                SizedBox(height: 20.h),

                //Don't Have Account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'dont_have_account'.tr(),
                      style: AppText.regularText(
                        color: textColor,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.only(left: 4.w),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {},
                      child: Text(
                        'create_one'.tr(),
                        style: AppText.boldText(
                          color: accentColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // OR Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: dividerColor, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        'OR',
                        style: AppText.mediumText(
                          color: textColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(color: dividerColor, thickness: 1),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                //Login With Google
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.g_mobiledata,
                    color: AppColors.primaryBlack,
                    size: 32,
                  ),
                  label: Text(
                    'login_with_google'.tr(),
                    style: AppText.semiBoldText(
                      color: AppColors.primaryBlack,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    elevation: 0,
                  ),
                ),

                SizedBox(height: 20.h),

                // Language Toggle
                Center(
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(30.r),
                      border: Border.all(
                        color: accentColor,
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildLanguageToggle(
                          context,
                          flagAsset: AppImages.usFlag,
                          isSelected: context.locale.languageCode == 'en',
                          langCode: 'en',
                          accentColor: accentColor,
                        ),
                        _buildLanguageToggle(
                          context,
                          flagAsset: AppImages.egyptFlag,
                          isSelected: context.locale.languageCode == 'ar',
                          langCode: 'ar',
                          accentColor: accentColor,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Icon Badge (green box with white icon)
  Widget _buildIconBadge(IconData icon) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: Container(
        width: 5.w,
        height: 5.w,
        decoration: BoxDecoration(
          color: AppColors.successGreen,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: AppColors.white,
          size: 18.sp,
        ),
      ),
    );
  }

  Widget _buildLanguageToggle(
    BuildContext context, {
    required String flagAsset,
    required bool isSelected,
    required String langCode,
    required Color accentColor,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isSelected) {
          context.setLocale(Locale(langCode));
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: ClipOval(
          child: Image.asset(
            flagAsset,
            width: 34.w,
            height: 34.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
