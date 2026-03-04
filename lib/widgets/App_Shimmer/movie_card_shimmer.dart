import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_shimmer.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AppShimmer.rectangular(
              height: 170.h,
              width: 140.w,
            ),
          ),
          SizedBox(height: 8.h),
          AppShimmer.rectangular(
            height: 12.h,
            width: 90.w,
          ),
        ],
      ),
    );
  }
}