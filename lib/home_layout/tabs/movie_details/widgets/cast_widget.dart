import 'package:flutter/material.dart';
import '../../../../core/image/app_assets.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/text/app_text.dart';

class CastWidget extends StatelessWidget {
  const CastWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => SizedBox(height: h(10)),
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: w(10),
            vertical: h(15),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).focusColor,
          ),
          child: Row(
            spacing: w(15),
            children: [
              Container(
                height: h(70),
                width: w(70),
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(AppAssets.startWatchingNow),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              Column(
                spacing: h(8),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : Hayley Atwell",
                    style: AppText.boldTextRoboto(
                        color: Theme.of(context).splashColor,
                        fontSize: sp(20)),
                  ),
                  Text(
                    "Character : Captain Carter",
                    style: AppText.boldTextRoboto(
                        color: Theme.of(context).splashColor,
                        fontSize: sp(20)),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
