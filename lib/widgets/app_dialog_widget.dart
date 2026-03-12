import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/text/app_text.dart';

class AppDialog {
  static Future show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = "OK",
    String cancelText = "Cancel",
    VoidCallback? onConfirm,
    bool showCancel = true,
  }) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            title,
            style: AppText.boldTextRoboto(
                color: Theme.of(context).splashColor, fontSize: 30.sp),
          ),
          content: Text(
            message,
            style: AppText.mediumText(
                color: Theme.of(context).splashColor, fontSize: 20.sp),
          ),
          actions: [
            if (showCancel)
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  cancelText,
                  style: AppText.boldTextRoboto(
                      color: Theme.of(context).splashColor, fontSize: 18.sp),
                ),
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                if (onConfirm != null) {
                  onConfirm();
                }
              },
              child: Text(
                confirmText,
                style: AppText.semiBoldText(
                    color: Theme.of(context).cardColor, fontSize: 18.sp),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showLoading(BuildContext context, Color circularColor) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return Center(
          child: CircularProgressIndicator(
            color: circularColor,
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
