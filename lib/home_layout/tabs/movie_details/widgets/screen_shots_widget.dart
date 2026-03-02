import 'package:flutter/material.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';

class ScreenShotsListWidget extends StatelessWidget {
  const ScreenShotsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.symmetric(
            vertical: h(8),
          ),
          height: h(167),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(AppAssets.discoverMovies),
            ),
          ),
        );
      },
    );
  }
}
