import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppText {
  static TextStyle regularText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle mediumText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semiBoldText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle boldText({
    required Color color,
    required double fontSize,
  }) {
    return GoogleFonts.inter(
      color: color,
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w700,
    );
  }
}
