import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color deepDarkBlueColor;
  final Color accentRedColor;
  final Color surfaceColor;

  final TextStyle headingLargeTextStyle;
  final TextStyle bodyLargeTextStyle;
  final TextStyle buttonLabelTextStyle;
  
  // just from copy
  final Color dividerColor;
  final Color chipColor;
  final Color ofWhiteColor;
  final Color descriptionColor;
  final Color jobApplicationAllColor;
  final Color jobApplicationPendingColor;
  final Color jobApplicationAcceptedColor;
  final Color jobApplicationRejectedColor;

  final TextStyle bodyStyle;
  final TextStyle textFieldStyle;
  final TextStyle hintStyle;
  final TextStyle richTextTitleStyle;

  const AppTheme({
    required this.deepDarkBlueColor,
    required this.headingLargeTextStyle,
    required this.bodyLargeTextStyle,
    required this.buttonLabelTextStyle,
    required this.bodyStyle,
    required this.textFieldStyle,
    required this.hintStyle,
    required this.accentRedColor,
    required this.richTextTitleStyle,
    required this.dividerColor,
    required this.surfaceColor,
    required this.chipColor,
    required this.ofWhiteColor,
    required this.descriptionColor,
    required this.jobApplicationAllColor,
    required this.jobApplicationPendingColor,
    required this.jobApplicationAcceptedColor,
    required this.jobApplicationRejectedColor,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? backgroundGradientStart,
    Color? backgroundGradientEnd,
    Color? accentBlue,
    Color? accentCyan,
    Color? accentPurple,
    Color? accentGray,
    Color? accentTeal,
    Color? accentLighterBlue,
    Color? accentDarkerPurple,
    Color? accentLighterCyan,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? labelStyle,
    TextStyle? bodyStyle,
    TextStyle? hintStyle,
    Color? blue,
    TextStyle? largeTitleStyle,
    TextStyle? textFieldStyle,
    TextStyle? richTextTitleStyle,
    Color? dividerColor,
    Color? grey,
    Color? chipColor,
    Color? ofWhiteColor,
    Color? descriptionColor,
    Color? jobApplicationAllColor,
    Color? jobApplicationPendingColor,
    Color? jobApplicationAcceptedColor,
    Color? jobApplicationRejectedColor,
  }) {
    return AppTheme(
      deepDarkBlueColor: accentLighterBlue ?? this.deepDarkBlueColor,
      headingLargeTextStyle: titleStyle ?? this.headingLargeTextStyle,
      bodyLargeTextStyle: subtitleStyle ?? this.bodyLargeTextStyle,
      buttonLabelTextStyle: labelStyle ?? this.buttonLabelTextStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      accentRedColor: blue ?? this.accentRedColor,
      richTextTitleStyle: richTextTitleStyle ?? this.richTextTitleStyle,
      textFieldStyle: textFieldStyle ?? this.textFieldStyle,
      dividerColor: dividerColor ?? this.dividerColor,
      surfaceColor: grey ?? this.surfaceColor,
      chipColor: chipColor ?? this.chipColor,
      ofWhiteColor: ofWhiteColor ?? this.ofWhiteColor,
      descriptionColor: descriptionColor ?? this.descriptionColor,
      jobApplicationAllColor:
          jobApplicationAllColor ?? this.jobApplicationAllColor,
      jobApplicationPendingColor:
          jobApplicationPendingColor ?? this.jobApplicationPendingColor,
      jobApplicationAcceptedColor:
          jobApplicationAcceptedColor ?? this.jobApplicationAcceptedColor,
      jobApplicationRejectedColor:
          jobApplicationRejectedColor ?? this.jobApplicationRejectedColor,
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
      headingLargeTextStyle: TextStyle.lerp(
        headingLargeTextStyle,
        other.headingLargeTextStyle,
        t,
      )!,
      bodyLargeTextStyle: TextStyle.lerp(
        bodyLargeTextStyle,
        other.bodyLargeTextStyle,
        t,
      )!,
      buttonLabelTextStyle: TextStyle.lerp(
        buttonLabelTextStyle,
        other.buttonLabelTextStyle,
        t,
      )!,
      bodyStyle: TextStyle.lerp(bodyStyle, other.bodyStyle, t)!,
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t)!,
      accentRedColor: Color.lerp(accentRedColor, other.accentRedColor, t)!,
      richTextTitleStyle: TextStyle.lerp(
        richTextTitleStyle,
        other.richTextTitleStyle,
        t,
      )!,
      textFieldStyle: TextStyle.lerp(textFieldStyle, other.textFieldStyle, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      chipColor: Color.lerp(chipColor, other.chipColor, t)!,
      ofWhiteColor: Color.lerp(ofWhiteColor, other.ofWhiteColor, t)!,
      descriptionColor: Color.lerp(
        descriptionColor,
        other.descriptionColor,
        t,
      )!,
      jobApplicationAllColor: Color.lerp(
        jobApplicationAllColor,
        other.jobApplicationAllColor,
        t,
      )!,
      jobApplicationPendingColor: Color.lerp(
        jobApplicationPendingColor,
        other.jobApplicationPendingColor,
        t,
      )!,
      jobApplicationAcceptedColor: Color.lerp(
        jobApplicationAcceptedColor,
        other.jobApplicationAcceptedColor,
        t,
      )!,
      jobApplicationRejectedColor: Color.lerp(
        jobApplicationRejectedColor,
        other.jobApplicationRejectedColor,
        t,
      )!,
    );
  }
}
