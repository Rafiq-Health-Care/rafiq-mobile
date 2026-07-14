import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppThemes {
  final AppTheme lightTheme = AppTheme(
    deepDarkBlueColor: Color(0XFF11325B),
    accentRedColor: Color(0xFFEF233C),
    accentGreenColor: Color(0xff34C759),
    surfaceColor: Colors.white,
    accentBlueColor: Color(0xFF2977F6),
    greyColor4: Color(0XFFA7A7A7),
    greyColor6: Color(0xFF3A3A3A),
    greyColor7: Color(0xFF6E6E6E),
    cyanColor400: Colors.cyan.shade400,
    softBlueColor: Color(0xFFB8CBE8),
    fieldFillColor: const Color(0x80F3F6FB),
    vibrantBlueColor: const Color(0xFF2C6ECB),
    surfaceMutedColor: const Color(0xFFF8FAFC),
    iconContainerColor: const Color(0xFFEFF6FF),
    avatarBackgroundColor: const Color(0xFFDBEAFE),

    headingLargeTextStyle: TextStyle(
      fontSize: 48.sp,
      fontWeight: FontWeight.w400,
      color: Colors.white,
      height: 1.2,
    ),
    headingTextStyle: TextStyle(
      fontSize: 32.sp,
      fontWeight: FontWeight.w600,
      color: Color(0XFF11325B),
    ),
    bodyLargeTextStyle: TextStyle(
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyTextStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Color(0xFF2977F6),
    ),
    buttonLabelTextStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    textFieldHintTextStyle: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Color(0XFF718094),
    ),
    textFieldTextStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w400,
      color: Color(0XFF1E1E24),
    ),
    textFieldLabelTextStyle: TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w500,
      color: Color(0xFF11325B),
    ),
    drawerLabelTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontSize: 16.sp,
      fontWeight: FontWeight.w500,
      color: Color(0xFF3A3A3A),
      height: 19 / 16, // line-height / font-size
      letterSpacing: 0,
    ),
    descriptionSmallTextStyle: TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.w300,
      color: Color(0xFF6E6E6E),
    ),
    popupMenuItemTextStyle: TextStyle(
      fontSize: 16.sp,
      color: Color(0xFF333333),
      fontWeight: FontWeight.w400,
    ),
    infoLabelTextStyle: TextStyle(
      color: Color(0xFF6E6E6E),
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      fontFamily: 'Inter',
    ),
    overlineTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontSize: 11.sp,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: Color(0xFF6E6E6E),
    ),
    valueTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: Color(0XFF11325B),
    ),
    captionTextStyle: TextStyle(
      fontFamily: 'Inter',
      fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: Color(0xFF3A3A3A),
    ),

    textFieldBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0XFF8BA9D2)),
    ),
  );
}
