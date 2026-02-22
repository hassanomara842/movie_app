import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/helpers/cache_helper.dart';
import '../../../core/colors/app_colors.dart';
import '../../../core/image/app_assets.dart';

class LanguageToggle extends StatefulWidget {
  const LanguageToggle({super.key});

  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  @override
  Widget build(BuildContext context) {
    final accentColor = Theme.of(context).colorScheme.secondary;
    final currentLanguageCode = context.locale.languageCode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
            border: Border.all(
              color: accentColor,
              width: 2,
            ),
          ),
          child: CacheHelper.getLanguage() == 'en'
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildLanguageToggle(
                      flagAsset: AppImages.lrImage,
                      isSelected: currentLanguageCode == 'en',
                      accentColor: accentColor,
                      onTap: () async {
                        if (currentLanguageCode != 'en') {
                          await context.setLocale(const Locale("en"));
                          await CacheHelper.setLanguage("en");
                          if (mounted) setState(() {});
                        }
                      },
                    ),
                    buildLanguageToggle(
                      flagAsset: AppImages.egyptImage,
                      isSelected: currentLanguageCode == 'ar',
                      accentColor: accentColor,
                      onTap: () async {
                        if (currentLanguageCode != 'ar') {
                          await context.setLocale(const Locale("ar"));
                          await CacheHelper.setLanguage("ar");
                          if (mounted) setState(() {});
                        }
                      },
                    ),
                  ],
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildLanguageToggle(
                      flagAsset: AppImages.egyptImage,
                      isSelected: currentLanguageCode == 'ar',
                      accentColor: accentColor,
                      onTap: () async {
                        if (currentLanguageCode != 'ar') {
                          await context.setLocale(const Locale("ar"));
                          await CacheHelper.setLanguage("ar");
                          if (mounted) setState(() {});
                        }
                      },
                    ),
                    buildLanguageToggle(
                      flagAsset: AppImages.lrImage,
                      isSelected: currentLanguageCode == 'en',
                      accentColor: accentColor,
                      onTap: () async {
                        if (currentLanguageCode != 'en') {
                          await context.setLocale(const Locale("en"));
                          await CacheHelper.setLanguage("en");
                          if (mounted) setState(() {});
                        }
                      },
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Widget buildLanguageToggle({
    required String flagAsset,
    required bool isSelected,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryYellow.withValues(alpha: 0.2)
              : AppColors.transparentColor,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: ClipOval(
          child: Image.asset(
            flagAsset,
            width: 34.w,
            height: 34.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
