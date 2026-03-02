import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/text/app_text.dart';

class GenresListWidget extends StatelessWidget {
  const GenresListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    final List<String> genres = [
      "Action",
      "Adventure",
      "Sci-Fi",
      "Drama",
      "Comedy",
    ];

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
                  genres[index],
                  style: AppText.regularTextRoboto(
                      color: Theme.of(context).primaryColor, fontSize: sp(18)),
                ),
              ],
            ));
      },
    );
  }
}
