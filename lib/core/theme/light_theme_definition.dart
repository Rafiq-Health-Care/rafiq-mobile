import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

const lightThemeDefinition = AppTheme(
  deepDarkBlueColor: Color(0XFF11325B),
  accentRedColor: Color(0xFFEF233C),
  surfaceColor: Colors.white,

  headingLargeTextStyle: TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.2,
  ),
  bodyLargeTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  ),
  buttonLabelTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),

  // just from copy
  textFieldStyle: TextStyle(
    fontSize: 20,
    color: Color(0XFF1E1E24),
    fontWeight: FontWeight.w500,
  ),

  hintStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Color(0xFF6E6E73),
  ),

  bodyStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: Color(0xFF1F2937),
  ),

  richTextTitleStyle: TextStyle(fontSize: 32, color: Color(0xFF1C1C1E)),
  dividerColor: Color(0xFFB9C2CA),
  chipColor: Color(0xFF42A5F5),
  ofWhiteColor: Color(0xFFEEF0F2),
  descriptionColor: Color(0xFF969294),
  jobApplicationAllColor: Color(0xFF64B5F6),
  jobApplicationPendingColor: Colors.grey,
  jobApplicationAcceptedColor: Color(0xFF81C784),
  jobApplicationRejectedColor: Color(0xFFE57373),
);
