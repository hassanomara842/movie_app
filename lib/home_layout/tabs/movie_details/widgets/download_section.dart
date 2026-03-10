import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/colors/app_colors.dart';
import 'package:movie_app/core/text/app_text.dart';
import 'package:movie_app/widgets/app_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../model/movie_details_response/movie_details_response.dart'
    as details;

class DownloadSection extends StatelessWidget {
  const DownloadSection({super.key, required this.movie});
  final details.Movie movie;

  Future<void> _launchUrl(BuildContext context, String url,
      {String? fallbackUrl}) async {
    final Uri uri = Uri.parse(url);
    try {
      final bool canLaunch = await canLaunchUrl(uri);

      if (canLaunch) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else if (fallbackUrl != null) {
        final Uri fallbackUri = Uri.parse(fallbackUrl);
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      } else {
        if (url.startsWith('magnet:')) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("No torrent app found. Please install one.")),
            );
          }
        } else {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  String _buildMagnetLink(String hash, String title) {
    return "magnet:?xt=urn:btih:$hash&dn=${Uri.encodeComponent(title)}&tr=udp://open.demonii.com:1337/announce&tr=udp://tracker.openbittorrent.com:80&tr=udp://tracker.coppersurfer.tk:6969&tr=udp://tracker.leechers-paradise.org:6969&tr=udp://zer0day.ch:1337/announce";
  }

  @override
  Widget build(BuildContext context) {
    if (movie.torrents == null || movie.torrents!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: movie.torrents!.map((torrent) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(12.r),
            border:
                Border.all(color: Theme.of(context).disabledColor, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${torrent.quality} - ${torrent.type?.toUpperCase()}",
                    style: AppText.boldTextRoboto(
                        color: AppColors.primaryYellow, fontSize: 18),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    torrent.size ?? "",
                    style: AppText.regularTextRoboto(
                        color: Theme.of(context).splashColor, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                width: 150.w,
                child: AppButton(
                  buttonTitle: "download".tr(),
                  onPressed: () {
                    if (torrent.hash != null && movie.title != null) {
                      _launchUrl(
                        context,
                        _buildMagnetLink(torrent.hash!, movie.title!),
                        fallbackUrl: torrent.url,
                      );
                    } else if (torrent.url != null) {
                      _launchUrl(context, torrent.url!);
                    }
                  },
                  backgroundColor: AppColors.primaryYellow,
                  textColor: AppColors.primaryBlack,
                  icon: const Icon(
                    Icons.download_rounded,
                    color: AppColors.primaryBlack,
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
