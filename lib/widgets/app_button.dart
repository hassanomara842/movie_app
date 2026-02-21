import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import '../core/text/app_text.dart';

class AppButton extends StatelessWidget {
  // kol attributes final 3ala el class
 final String buttonTitle;
 final VoidCallback onPressed;
 final Color backgroundColor;
 final Color borderSideColor;
 final Color textColor;
 final bool isIcon;
 final IconData? icon;

  const AppButton({
    super.key,
    required this.buttonTitle,
    required this.onPressed,
    required this.backgroundColor,
    this.isIcon = false,
    this.icon,
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
      child: isIcon
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    buttonTitle,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: AppText.semiBoldText(
                      color: textColor,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
                SizedBox(width: 5.w),
                Icon(
                  icon,
                  color: textColor,
                  size: 20.sp,
                ),
              ],
            )
          : Text(
              buttonTitle,
              style: AppText.semiBoldText(color: textColor, fontSize: 20.sp),
            ),
    );
  }
}
