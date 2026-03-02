import 'package:flutter/material.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import 'icon_text_widget.dart';

class SimilerWidget extends StatelessWidget {
  const SimilerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: w(10),
        mainAxisSpacing: h(10),
        childAspectRatio: 191 / 279,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.all(w(10)),
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(AppAssets.startWatchingNow),
              ),
            ),
            child: const IconTextWidget(
              text: "7.5",
              image: AppAssets.star,
            ),
          ),
        );
      },
    );
  }
}
