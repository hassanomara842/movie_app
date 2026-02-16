import 'package:flutter/material.dart';


class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.validator,
    this.cursorColor,
    this.style,
    this.decoration,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final String? Function(String?)? validator;
  final Color? cursorColor;
  final TextStyle? style;
  final InputDecoration? decoration;
  final ValueChanged<String>? onFieldSubmitted;
  final bool obscureText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      validator: validator,
      cursorColor: cursorColor,
      style: style,
      decoration: decoration,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      enabled: enabled,
    );
  }
}

