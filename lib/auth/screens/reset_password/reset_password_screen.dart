import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/image/app_assets.dart';
import '../../../../widgets/app_button.dart';
import 'package:movie_app/widgets/custom_text_form_field.dart';
import 'package:movie_app/core/text/app_text.dart';
import '../../../core/responsive/responsive.dart';
import '../../../core/responsive/size_config.dart';

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
      return 'email_is_required'.tr();
    }

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(email)) {
      return 'enter_a_valid_email'.tr();
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
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          'forget_password'.tr(),
          style: AppText.regularText(
            color: Theme.of(context).cardColor,
            fontSize: 18.sp,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: h(18),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(AppImages.forgetPassword),
                      CustomTextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.done,
                        autofillHints: const [AutofillHints.email],
                        validator: validateEmail,
                        cursorColor: Theme.of(context).cardColor,
                        style: AppText.regularText(
                          color: Theme.of(context).splashColor,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          errorStyle: AppText.boldText(
                            color: Theme.of(context).cardColor,
                            fontSize: 17.sp,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Theme.of(context).cardColor,
                              width: 1.0,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Theme.of(context).splashColor,
                              width: 1.0,
                            ),
                          ),
                          filled: true,
                          focusColor: Theme.of(context).primaryColor,
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: w(14),
                              vertical: h(14),
                            ),
                            child: SvgPicture.asset(
                              AppImages.emailIcon,
                              width: w(20),
                              height: h(20),
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).splashColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          fillColor: Theme.of(context).primaryColor,
                          hintText: 'email'.tr(),
                          hintStyle: AppText.semiBoldText(
                            color: Theme.of(context).splashColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        onFieldSubmitted: (context) => onResetPressed(),
                      ),
                      AppButton(
                          buttonTitle: 'verify_email'.tr(),
                          onPressed: () {
                            onResetPressed();
                          },
                          backgroundColor: Theme.of(context).cardColor)
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
