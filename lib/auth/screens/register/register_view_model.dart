import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RegisterViewModel {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "name_is_required".tr();
    }
    if (value.length < 3) {
      return "name_min_length".tr();
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "email_is_required".tr();
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "enter_a_valid_email".tr();
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "password_is_required".tr();
    }
    if (value.length < 6) {
      return "password_min_length".tr();
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "confirm_password_is_required".tr();
    }
    if (value != passwordController.text) {
      return "passwords_do_not_match".tr();
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return "phone_number_is_required".tr();
    }
    if (!RegExp(r'^\d{11}$').hasMatch(value)) {
      return "enter_valid_phone_number".tr();
    }
    return null;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
  }
}
