import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color deepDarkBlueColor;
  final Color accentRedColor;
  final Color surfaceColor;
  final Color accentBlueColor;
  final Color greyColor6;
  final Color cyanColor400;

  final TextStyle headingLargeTextStyle;
  final TextStyle headingTextStyle;
  final TextStyle bodyLargeTextStyle;
  final TextStyle bodyTextStyle;
  final TextStyle buttonLabelTextStyle;
  final TextStyle textFieldHintTextStyle;
  final TextStyle textFieldTextStyle;
  final TextStyle textFieldLabelTextStyle;
  final TextStyle drawerLabelTextStyle;

  final InputBorder textFieldBorder;
  const AppTheme({
    required this.deepDarkBlueColor,
    required this.accentRedColor,
    required this.accentBlueColor,
    required this.surfaceColor,
    required this.greyColor6,
    required this.cyanColor400,
    required this.headingLargeTextStyle,
    required this.headingTextStyle,
    required this.bodyLargeTextStyle,
    required this.bodyTextStyle,
    required this.buttonLabelTextStyle,
    required this.textFieldLabelTextStyle,
    required this.textFieldTextStyle,
    required this.textFieldHintTextStyle,
    required this.drawerLabelTextStyle,
    required this.textFieldBorder,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? deepDarkBlueColor,
    Color? accentRedColor,
    Color? surfaceColor,
    Color? accentBlueColor,
    Color? greyColor6,
    Color? cyanColor400,
    TextStyle? headingLargeTextStyle,
    TextStyle? headingTextStyle,
    TextStyle? bodyLargeTextStyle,
    TextStyle? bodyTextStyle,
    TextStyle? buttonLabelTextStyle,
    TextStyle? textFieldLabelTextStyle,
    TextStyle? textFieldHintTextStyle,
    TextStyle? textFieldTextStyle,
    TextStyle? drawerLabelTextStyle,
    InputBorder? textFieldBorder,
  }) {
    return AppTheme(
      deepDarkBlueColor: deepDarkBlueColor ?? this.deepDarkBlueColor,
      accentRedColor: accentRedColor ?? this.accentRedColor,
      accentBlueColor: accentBlueColor ?? this.accentBlueColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      greyColor6: greyColor6 ?? this.greyColor6,
      cyanColor400: cyanColor400 ?? this.cyanColor400,
      headingLargeTextStyle:
          headingLargeTextStyle ?? this.headingLargeTextStyle,
      headingTextStyle: headingTextStyle ?? this.headingTextStyle,
      bodyLargeTextStyle: bodyLargeTextStyle ?? this.bodyLargeTextStyle,
      bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
      buttonLabelTextStyle: buttonLabelTextStyle ?? this.buttonLabelTextStyle,
      textFieldLabelTextStyle:
          textFieldLabelTextStyle ?? this.textFieldLabelTextStyle,
      textFieldHintTextStyle:
          textFieldHintTextStyle ?? this.textFieldHintTextStyle,
      textFieldTextStyle: textFieldTextStyle ?? this.textFieldTextStyle,
      drawerLabelTextStyle: drawerLabelTextStyle ?? this.drawerLabelTextStyle,
      textFieldBorder: textFieldBorder ?? this.textFieldBorder,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) {
      return this;
    }
    return AppTheme(
      deepDarkBlueColor: Color.lerp(
        deepDarkBlueColor,
        other.deepDarkBlueColor,
        t,
      )!,
      accentRedColor: Color.lerp(accentRedColor, other.accentRedColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      accentBlueColor: Color.lerp(accentBlueColor, other.accentBlueColor, t)!,
      greyColor6: Color.lerp(greyColor6, other.greyColor6, t)!,
      cyanColor400: Color.lerp(cyanColor400, other.cyanColor400, t)!,

      headingLargeTextStyle: TextStyle.lerp(
        headingLargeTextStyle,
        other.headingLargeTextStyle,
        t,
      )!,
      headingTextStyle: TextStyle.lerp(
        headingTextStyle,
        other.headingTextStyle,
        t,
      )!,
      bodyLargeTextStyle: TextStyle.lerp(
        bodyLargeTextStyle,
        other.bodyLargeTextStyle,
        t,
      )!,
      bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t)!,
      buttonLabelTextStyle: TextStyle.lerp(
        buttonLabelTextStyle,
        other.buttonLabelTextStyle,
        t,
      )!,
      textFieldLabelTextStyle: TextStyle.lerp(
        textFieldLabelTextStyle,
        other.textFieldLabelTextStyle,
        t,
      )!,
      textFieldHintTextStyle: TextStyle.lerp(
        textFieldHintTextStyle,
        other.textFieldHintTextStyle,
        t,
      )!,

      textFieldTextStyle: TextStyle.lerp(
        textFieldTextStyle,
        other.textFieldTextStyle,
        t,
      )!,
      drawerLabelTextStyle: TextStyle.lerp(
        drawerLabelTextStyle,
        other.drawerLabelTextStyle,
        t,
      )!,

      textFieldBorder: textFieldBorder,
    );
  }
}
