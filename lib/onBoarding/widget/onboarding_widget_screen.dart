import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/text/app_text.dart';

class OnboardingWidgetScreen extends StatelessWidget {
  String backgroundImage;
  Color containerColor;
  String title;
  String content;
  final List<Widget> buttons;
  double titleFontSize;
  double contentFontSize;
  Color contentTextColor;
  double spacing;

  OnboardingWidgetScreen({
    super.key,
    required this.backgroundImage,
    required this.containerColor,
    required this.title,
    this.content = "",
    required this.buttons,
    required this.titleFontSize,
    required this.contentFontSize,
    this.contentTextColor = const Color.fromRGBO(255, 255, 255, 0.6),
    this.spacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(40),
                topEnd: Radius.circular(40),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    spacing: spacing.h,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        title,
                        style: AppText.boldText(
                          color: Colors.white,
                          fontSize: titleFontSize,
                        ),
                      ),
                      if (content.isNotEmpty)
                        Text(
                          textAlign: TextAlign.center,
                          content,
                          style: AppText.regularText(
                            color: contentTextColor,
                            fontSize: contentFontSize,
                          ),
                        ),
                      if (buttons.isNotEmpty) ...buttons,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
