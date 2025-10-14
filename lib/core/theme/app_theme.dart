import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color deepDarkBlueColor;
  final Color accentRedColor;
  final Color surfaceColor;
  final Color accentBlueColor;

  final TextStyle headingLargeTextStyle;
  final TextStyle headingTextStyle;
  final TextStyle bodyLargeTextStyle;
  final TextStyle bodyTextStyle;
  final TextStyle buttonLabelTextStyle;
  final TextStyle textFieldHintTextStyle;
  final TextStyle textFieldTextStyle;
  final TextStyle textFieldLabelTextStyle;

  const AppTheme({
    required this.deepDarkBlueColor,
    required this.accentRedColor,
    required this.accentBlueColor,
    required this.surfaceColor,
    required this.headingLargeTextStyle,
    required this.headingTextStyle,
    required this.bodyLargeTextStyle,
    required this.bodyTextStyle,
    required this.buttonLabelTextStyle,
    required this.textFieldLabelTextStyle,
    required this.textFieldTextStyle,
    required this.textFieldHintTextStyle,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? deepDarkBlueColor,
    Color? accentRedColor,
    Color? surfaceColor,
    Color? accentBlueColor,
    TextStyle? headingLargeTextStyle,
    TextStyle? headingTextStyle,
    TextStyle? bodyLargeTextStyle,
    TextStyle? bodyTextStyle,
    TextStyle? buttonLabelTextStyle,
    TextStyle? textFieldLabelTextStyle,
    TextStyle? textFieldHintTextStyle,
    TextStyle? textFieldTextStyle,
  }) {
    return AppTheme(
      deepDarkBlueColor: deepDarkBlueColor ?? this.deepDarkBlueColor,
      accentRedColor: accentRedColor ?? this.accentRedColor,
      accentBlueColor: accentBlueColor ?? this.accentBlueColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
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
    );
  }
}
