import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/auth/screens/register/register_view_model.dart';
import 'package:movie_app/widgets/build_inputs.dart';
import 'package:movie_app/auth/screens/language_toggle/language_toggle.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/widgets/app_button.dart';
import '../../../core/image/app_assets.dart';
import '../../../core/routing/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterViewModel viewModel = RegisterViewModel();

  final List<String> avatars = [
    AppImages.avatar,
    AppImages.avatar1,
    AppImages.avatar2,
    AppImages.avatar3,
    AppImages.avatar4,
    AppImages.avatar5,
    AppImages.avatar6,
    AppImages.avatar7,
    AppImages.avatar8,
  ];

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      avatars[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 115,
                  viewportFraction: 0.34,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
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
              ),

              /// Create Account Button
              AppButton(
                buttonTitle: "create_account".tr(),
                backgroundColor: Theme.of(context).cardColor,
                onPressed: () {
                  if (viewModel.validateForm()) {
                    debugPrint("Form is valid");
                    Navigator.of(context).pushNamed(AppRoutes.profileScreen);
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
                    //navigate back to login
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("login".tr(),
                        style: AppText.boldText(
                            color: Theme.of(context).cardColor,
                            fontSize: 18.sp)),
                  ),
                ],
              ),
              const LanguageToggle(),
            ],
          ),
        ),
      ),
    );
  }
}
