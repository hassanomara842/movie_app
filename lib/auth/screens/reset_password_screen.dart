import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/auth/widget/custom_text_form_field.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/text/app_text.dart';

import '../../core/responsive/responsive.dart';
import '../../core/responsive/size_config.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String? validateEmail(String? value) {
    final email = (value ?? '').trim();
    if (email.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  void onResetPressed() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: AppColors.primaryBlack,
      appBar: AppBar(
        backgroundColor: AppColors.primaryBlack,
        leading: const BackButton(color: AppColors.primaryYellow),
        centerTitle: true,
        title: Text(
          'Forget Password',
          style: AppText.regularText(
            color: AppColors.primaryYellow,
            fontSize: 16,
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final bottomInset = MediaQuery.of(context).viewInsets.bottom;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(w(16), 0, w(16), bottomInset),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/Forgot_password.png'),
                      SizedBox(height: h(18)),
                      CustomTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.email],
                        validator: validateEmail,
                        cursorColor: AppColors.primaryYellow,
                        style: AppText.regularText(
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          errorStyle: AppText.regularText(
                            color: AppColors.primaryYellow,
                            fontSize: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          focusColor: AppColors.white,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: SvgPicture.asset(
                              'assets/images/Email_icon.svg',
                              width: w(20),
                              height: h(20),
                              colorFilter: const ColorFilter.mode(
                                AppColors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          fillColor: AppColors.darkGrey,
                          hintText: ' Email',
                          hintStyle: AppText.semiBoldText(
                            color: AppColors.white,
                            fontSize: 16,
                          ),
                        ),
                        onFieldSubmitted: (context) => onResetPressed(),
                      ),
                      SizedBox(height: h(24)),
                      ElevatedButton(
                        onPressed: onResetPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryYellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          minimumSize: Size(double.infinity, h(48)),
                        ),
                        child:  Text('Verify Email',
                          style: AppText.boldText(
                            color: AppColors.primaryBlack,
                            fontSize: 16,
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
