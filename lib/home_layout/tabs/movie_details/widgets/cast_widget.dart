import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/model/movie_details_response/movie_details_response.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/size_config.dart';
import '../../../../core/text/app_text.dart';

class CastWidget extends StatelessWidget {
  final List<Cast>? cast;
  const CastWidget({super.key, this.cast});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    if (cast == null || cast!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cast!.length,
      padding: EdgeInsets.zero,
      separatorBuilder: (context, index) => SizedBox(height: h(10)),
      itemBuilder: (context, index) {
        final actor = cast![index];
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
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: actor.urlSmallImage ?? "",
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  spacing: h(8),
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ${actor.name ?? ""}",
                      overflow: TextOverflow.ellipsis,
                      style: AppText.boldTextRoboto(
                          color: Theme.of(context).splashColor,
                          fontSize: sp(20)),
                    ),
                    Text(
                      "Character : ${actor.characterName ?? ""}",
                      overflow: TextOverflow.ellipsis,
                      style: AppText.boldTextRoboto(
                          color: Theme.of(context).splashColor,
                          fontSize: sp(20)),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
