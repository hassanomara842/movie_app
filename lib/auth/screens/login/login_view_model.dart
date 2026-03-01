import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoginViewModel {
  final emailController = TextEditingController(text: "nouramer355@gmail.com");
  final passwordController = TextEditingController(text: '123456');
  final formKey = GlobalKey<FormState>();
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_email'.tr();
    }
    final bool emailValid =
    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (!emailValid) {
      return 'please_enter_valid_email'.tr();
    }
    return null;
  }
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'please_enter_password'.tr();
    }
    if (value.length < 6) {
      return 'password_too_short'.tr();
    }
    return null;
  }
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }
}