import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';

import '../../core/text/app_text.dart';

class OnboardingButton extends StatelessWidget {
  String buttonTitle;
  VoidCallback onPressed;
  Color backgroundColor;
  Color borderSideColor;
  Color textColor;

  OnboardingButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
    required this.backgroundColor,
    this.borderSideColor = Colors.transparent,
    this.textColor = AppColors.primaryBlack,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: borderSideColor, width: 2),
          ),
        ),
        padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: 15.h)),
      ),
      onPressed: onPressed,
      child: Text(
        buttonTitle,
        style: AppText.semiBoldText(color: textColor, fontSize: 20.sp),
      ),
    );
  }
}
