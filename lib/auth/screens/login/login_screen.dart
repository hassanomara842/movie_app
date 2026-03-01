import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/screens/language_toggle/language_toggle.dart';
import 'package:movie_app/auth/screens/login/login_view_model.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/build_inputs.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel viewModel = LoginViewModel();
  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthSuccess) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.homeLayout,
          (route) => false,
        );
      }

      if (state is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                spacing: 25.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    AppAssets.logoImage,
                    height: 180.h,
                  ),

                  /// Email Input
                  BuildInputs(
                    controller: viewModel.emailController,
                    icon: Icons.email_outlined,
                    hint: 'email'.tr(),
                    textInputType: TextInputType.emailAddress,
                    validator: viewModel.validateEmail,
                  ),

                  /// Password Input
                  BuildInputs(
                    controller: viewModel.passwordController,
                    icon: Icons.lock_outline,
                    hint: 'password'.tr(),
                    isPass: true,
                    validator: viewModel.validatePassword,
                    textInputAction: TextInputAction.done,
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
                          color: Theme.of(context).cardColor,
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                  ),

                  /// Login Button
                  AppButton(
                    buttonTitle: 'login'.tr(),
                    onPressed: () {
                      if (viewModel.validateForm()) {
                        context.read<AuthCubit>().login(
                              viewModel.emailController.text.trim(),
                              viewModel.passwordController.text.trim(),
                            );
                      }
                    },
                    backgroundColor: Theme.of(context).cardColor,
                    textColor: AppColors.primaryBlack,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'dont_have_account'.tr(),
                        style: AppText.regularText(
                          color: Theme.of(context).splashColor,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.only(left: 4.w),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.registerScreen);
                        },
                        child: Text(
                          'create_one'.tr(),
                          style: AppText.boldText(
                            color: Theme.of(context).cardColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                            color: Theme.of(context).disabledColor,
                            thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Text(
                          'or'.tr(),
                          style: AppText.mediumText(
                            color: Theme.of(context).splashColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                            color: Theme.of(context).disabledColor,
                            thickness: 1),
                      ),
                    ],
                  ),

                  AppButton(
                      buttonTitle: 'login_with_google'.tr(),
                      onPressed: () {
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                      icon: Image.asset(
                        AppAssets.googleIcon,
                        width: 25.w,
                        height: 25.h,
                      ),
                      isIcon: true,
                      backgroundColor: Theme.of(context).cardColor),

                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LanguageToggle(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
