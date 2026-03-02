import 'package:flutter/material.dart';

import '../../../../core/colors/app_colors.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/text/app_text.dart';

class IconTextWidget extends StatelessWidget {
  final String text;
  final String image;
  const IconTextWidget({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(15), vertical: h(10)),
      decoration: BoxDecoration(
        color: AppColors.darkGrey.withAlpha(150),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: w(10),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            fit: BoxFit.contain,
            height: h(25),
          ),
          Text(
            text,
            style: AppText.regularTextRoboto(
                color: AppColors.white, fontSize: sp(25)),
          ),
        ],
      ),
    );
  }
}
