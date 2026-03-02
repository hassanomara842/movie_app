import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/text/app_text.dart';

class GenresListWidget extends StatelessWidget {
  final List<String> genres;
  const GenresListWidget({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: genres.length,
      padding: EdgeInsets.only(
        left: w(0),
        right: w(0),
        bottom: h(50),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: w(8),
        mainAxisSpacing: h(8),
        childAspectRatio: 2.8,
      ),
      itemBuilder: (context, index) {
        return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).focusColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: w(10),
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  genres[index].tr(),
                  style: AppText.regularTextRoboto(
                      color: Theme.of(context).splashColor, fontSize: sp(18)),
                ),
              ],
            ));
      },
    );
  }
}
