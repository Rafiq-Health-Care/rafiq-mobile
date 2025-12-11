import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

final AppTheme lightThemeDefinition = AppTheme(
  deepDarkBlueColor: Color(0XFF11325B),
  accentRedColor: Color(0xFFEF233C),
  surfaceColor: Colors.white,
  accentBlueColor: Color(0xFF2977F6),
  greyColor6: Color(0xFF3A3A3A),

  headingLargeTextStyle: TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w400,
    color: Colors.white,
    height: 1.2,
  ),
  headingTextStyle: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Color(0XFF11325B),
  ),
  bodyLargeTextStyle: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  bodyTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF2977F6),
  ),
  buttonLabelTextStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  textFieldHintTextStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  ),
  textFieldTextStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: Color(0XFF1E1E24),
  ),
  textFieldLabelTextStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Color(0xFF11325B),
  ),
  drawerLabelTextStyle: TextStyle(
    fontFamily: 'Inter',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF3A3A3A),
    height: 19 / 16, // line-height / font-size
    letterSpacing: 0,
  ),
  textFieldBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: Colors.grey[300]!),
  ),
);
