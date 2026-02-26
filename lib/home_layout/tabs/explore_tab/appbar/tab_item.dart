import 'package:flutter/material.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/text/app_text.dart';

class TabItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const TabItem({
    required this.isSelected,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: w(16), vertical: h(8)),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).cardColor
            : AppColors.transparentColor,
        border: Border.all(
          color: isSelected ? Colors.transparent : Theme.of(context).cardColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: isSelected
            ? AppText.mediumText(color: AppColors.white, fontSize: 16)
            : AppText.mediumText(
                color: Theme.of(context).splashColor,
                fontSize: 16,
              ),
      ),
    );
  }
}
