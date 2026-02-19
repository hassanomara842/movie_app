import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/text/app_text.dart';
import 'custom_text_form_field.dart';

class BuildInputs extends StatefulWidget {
  final IconData icon;
  final String hint;
  final bool isPass;
  final TextInputType? textInputType;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  bool obscureText = false;

  BuildInputs(
      {super.key,
      required this.icon,
      required this.hint,
      this.isPass = false,
      required this.controller,
      required this.obscureText,
      this.validator,
      this.textInputType});

  @override
  State<BuildInputs> createState() => _BuildInputsState();
}

class _BuildInputsState extends State<BuildInputs> {
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      cursorColor: Theme.of(context).splashColor,
      keyboardType: widget.textInputType,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      style: AppText.regularText(
          color: Theme.of(context).splashColor, fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: widget.hint,
        errorStyle: AppText.regularText(
            color: Theme.of(context).cardColor, fontSize: 16.sp),
        hintStyle: AppText.regularText(
            color: Theme.of(context).splashColor, fontSize: 16.sp),
        prefixIcon: Icon(widget.icon, color: Theme.of(context).splashColor),
        suffixIcon: widget.isPass
            ? IconButton(
                onPressed: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                icon: Icon(
                  widget.obscureText
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Theme.of(context).splashColor,
                ),
              )
            : null,
        filled: true,
        fillColor: Theme.of(context).canvasColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 18.h),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
              width: 1.w,
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
              width: 1.w,
            )),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).cardColor,
              width: 2.w,
            )),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).cardColor,
              width: 2.w,
            )),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Theme.of(context).disabledColor,
              width: 1.w,
            )),
      ),
    );
  }
}
