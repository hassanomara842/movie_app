import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/responsive/responsive.dart';
import 'package:movie_app/core/responsive/size_config.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/build_inputs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final textColor = isDark ? AppColors.white : AppColors.primaryBlack;
    final accentColor = AppColors.primaryYellow;
    final dividerColor = isDark ? Colors.white24 : Colors.black12;

    return Scaffold(
      backgroundColor: isDark ? AppColors.primaryBlack : Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w(24)),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: h(50)),
                Center(
                  child: SizedBox(
                    width: w(140),
                    height: h(140),
                    child: Image.asset(
                      AppImages.splashLogo,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: h(48)),
                BuildInputs(
                  controller: _emailController,
                  icon: Icons.email_outlined,
                  hint: 'email'.tr(),
                  obscureText: false,
                  textInputType: TextInputType.emailAddress,
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

                SizedBox(height: h(16)),
                BuildInputs(
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                  hint: 'password'.tr(),
                  obscureText: true,
                  isPass: true,
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

                SizedBox(height: h(8)),
                AppButton(
                  buttonTitle: 'login'.tr(),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.profileScreen, (route) => false);
                    }
                  },
                  backgroundColor: accentColor,
                  textColor: AppColors.primaryBlack,
                ),

                SizedBox(height: h(20)),
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
                        padding: EdgeInsets.only(left: w(4)),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.registerScreen);
                      },
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

                SizedBox(height: h(16)),
                Row(
                  children: [
                    Expanded(
                      child: Divider(color: dividerColor, thickness: 1),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: w(12)),
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

                SizedBox(height: h(20)),
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
                    padding: EdgeInsets.symmetric(vertical: h(14)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(w(14)),
                    ),
                    elevation: 0,
                  ),
                ),

                SizedBox(height: h(20)),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(w(4)),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(w(30)),
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
                          flagAsset: AppImages.lrImage,
                          isSelected: context.locale.languageCode == 'en',
                          langCode: 'en',
                          accentColor: accentColor,
                        ),
                        _buildLanguageToggle(
                          context,
                          flagAsset: AppImages.egyptImage,
                          isSelected: context.locale.languageCode == 'ar',
                          langCode: 'ar',
                          accentColor: accentColor,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: h(24)),
              ],
            ),
          ),
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
        padding: EdgeInsets.symmetric(horizontal: w(8), vertical: h(6)),
        decoration: BoxDecoration(
          color: isSelected
              ? accentColor.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(w(20)),
        ),
        child: ClipOval(
          child: Image.asset(
            flagAsset,
            width: w(34),
            height: h(34),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
