import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconColor,
    this.prefixIconColor,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.filled = false,
    this.fillColor,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.borderRadius = 16,
    this.maxLines,
    this.validator,
    this.controller,
    this.onChanged,
    this.keyboardType,
    this.obscureText = false,
    this.style,
    this.cursorColor,
    this.textInputAction,
    this.autofillHints,
    this.onFieldSubmitted,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.contentPadding,
    this.border,
    this.errorStyle,
    this.focusColor,
  });

  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? suffixIconColor;
  final Color? prefixIconColor;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool filled;
  final Color? fillColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final int? maxLines;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool obscureText;
  final TextStyle? style;
  final Color? cursorColor;
  final TextInputAction? textInputAction;
  final List<String>? autofillHints;
  final void Function(String)? onFieldSubmitted;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final OutlineInputBorder? border;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;
  final Color? focusColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      maxLines: obscureText ? 1 : maxLines,
      obscureText: obscureText,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      style: style,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle,
        hintText: hintText,
        hintStyle: hintStyle,
        filled: filled,
        fillColor: fillColor,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        prefixIconColor: prefixIconColor,
        suffixIconColor: suffixIconColor,
        border: border,
        errorStyle: errorStyle,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        focusColor: focusColor,
        errorBorder: errorBorder,
        contentPadding: contentPadding,
        focusedErrorBorder: focusedErrorBorder,
      ),
    );
  }
}
