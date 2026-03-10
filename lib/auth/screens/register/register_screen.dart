import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/screens/language_toggle/language_toggle.dart';
import 'package:movie_app/auth/screens/register/register_view_model.dart';
import 'package:movie_app/core/image/app_assets.dart';
import 'package:movie_app/core/routing/app_routes.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:movie_app/widgets/build_inputs.dart';
import '../../../core/colors/app_colors.dart';
import '../../../cubit/auth_cubit.dart';
import '../../../cubit/auth_states.dart';
import '../../../widgets/app_dialog_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterViewModel viewModel = RegisterViewModel();

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

  int selectedAvatarIndex = 0;

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthLoading) {
        AppDialog.showLoading(context, AppColors.primaryYellow);
      }

      if (state is AuthSuccess) {
        AppDialog.hideLoading(context);

        AppDialog.show(
          context: context,
          title: "success".tr(),
          message: "registration_successful".tr(),
          showCancel: false,
          confirmText: "OK".tr(),
          onConfirm: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login,
              (route) => false,
            );
          },
        );
      }

      if (state is AuthError) {
        AppDialog.hideLoading(context);

        AppDialog.show(
          context: context,
          title: "error".tr(),
          message: state.message,
          showCancel: false,
          confirmText: "OK".tr(),
        );
      }
    }, builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: Theme.of(context).cardColor,
            ),
            title: Text("register".tr(),
                style: AppText.regularText(
                    color: Theme.of(context).cardColor, fontSize: 16.sp)),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: Form(
              key: viewModel.formKey,
              child: Column(
                spacing: 24.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CarouselSlider.builder(
                    itemCount: avatars.length,
                    itemBuilder: (context, index, realIndex) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatarIndex = index;
                          });
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            decoration: BoxDecoration(
                              border: selectedAvatarIndex == index
                                  ? Border.all(
                                      color: Theme.of(context).primaryColor,
                                      width: 3,
                                    )
                                  : null,
                            ),
                            child: Image.asset(
                              avatars[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 115,
                      viewportFraction: 0.34,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      enableInfiniteScroll: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          selectedAvatarIndex = index;
                        });
                      },
                    ),
                  ),

                  /// Name
                  BuildInputs(
                    controller: viewModel.nameController,
                    icon: Icons.badge_outlined,
                    hint: "name".tr(),
                    isPass: false,
                    validator: viewModel.validateName,
                  ),

                  /// Email
                  BuildInputs(
                    controller: viewModel.emailController,
                    icon: Icons.email_outlined,
                    hint: "email".tr(),
                    isPass: false,
                    validator: viewModel.validateEmail,
                    textInputType: TextInputType.emailAddress,
                  ),

                  /// Password
                  BuildInputs(
                    controller: viewModel.passwordController,
                    icon: Icons.lock_outline,
                    hint: "password".tr(),
                    validator: viewModel.validatePassword,
                    isPass: true,
                  ),

                  /// Confirm Password
                  BuildInputs(
                    controller: viewModel.confirmPasswordController,
                    icon: Icons.lock_outline,
                    hint: "confirm_password".tr(),
                    validator: viewModel.validateConfirmPassword,
                    isPass: true,
                  ),

                  /// Phone
                  BuildInputs(
                    controller: viewModel.phoneController,
                    icon: Icons.phone,
                    hint: "phone_number".tr(),
                    isPass: false,
                    validator: viewModel.validatePhone,
                    textInputType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                  ),

                  /// Create Account Button
                  AppButton(
                    buttonTitle: "create_account".tr(),
                    backgroundColor: Theme.of(context).cardColor,
                    onPressed: () {
                      if (viewModel.validateForm()) {
                        context.read<AuthCubit>().register(
                              name: viewModel.nameController.text.trim(),
                              email: viewModel.emailController.text.trim(),
                              password:
                                  viewModel.passwordController.text.trim(),
                              phone: viewModel.phoneController.text.trim(),
                              avaterId: selectedAvatarIndex + 1,
                            );
                      }
                    },
                  ),

                  /// Already Have Account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("already_have_account".tr(),
                          style: AppText.regularText(
                              color: Theme.of(context).splashColor,
                              fontSize: 18.sp)),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AppRoutes.login);
                        },
                        child: Text("login".tr(),
                            style: AppText.boldText(
                                color: Theme.of(context).cardColor,
                                fontSize: 18.sp)),
                      ),
                    ],
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LanguageToggle(),
                    ],
                  ),
                ],
              ),
            ),
          ));
    });
  }
}
