import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color deepDarkBlueColor;
  final Color accentRedColor;
  final Color accentGreenColor;
  final Color surfaceColor;
  final Color accentBlueColor;
  final Color greyColor4;
  final Color greyColor6;
  final Color greyColor7;
  final Color cyanColor400;
  final Color softBlueColor;
  final Color fieldFillColor;
  final Color vibrantBlueColor;
  final Color surfaceMutedColor;
  final Color iconContainerColor;
  final Color avatarBackgroundColor;
  final Color pageBackgroundColor;
  final Color borderColor;
  final Color labelColor;
  final Color placeholderColor;
  final Color mutedTextColor;
  final Color secondaryTextColor;
  final Color tealAccentColor;
  final Color infoBackgroundColor;
  final Color infoBorderColor;
  final Color warningBackgroundColor;
  final Color warningColor;
  final Color inputTextColor;
  final Color bodyMutedColor;
  final Color cardBorderColor;
  final Color lightIconContainerColor;
  final Color secondaryBorderColor;
  final Color mutedHintColor;
  final Color starColor;
  final Color dividerColor;

  final TextStyle headingLargeTextStyle;
  final TextStyle headingTextStyle;
  final TextStyle bodyLargeTextStyle;
  final TextStyle bodyTextStyle;
  final TextStyle buttonLabelTextStyle;
  final TextStyle textFieldHintTextStyle;
  final TextStyle textFieldTextStyle;
  final TextStyle textFieldLabelTextStyle;
  final TextStyle drawerLabelTextStyle;
  final TextStyle descriptionSmallTextStyle;
  final TextStyle popupMenuItemTextStyle;
  final TextStyle infoLabelTextStyle;
  final TextStyle overlineTextStyle; 
  final TextStyle valueTextStyle; 
  final TextStyle captionTextStyle;

  final InputBorder textFieldBorder;
  const AppTheme({
    required this.deepDarkBlueColor,
    required this.accentRedColor,
    required this.accentGreenColor,
    required this.accentBlueColor,
    required this.surfaceColor,
    required this.greyColor4,
    required this.greyColor6,
    required this.greyColor7,
    required this.cyanColor400,
    required this.softBlueColor,
    required this.fieldFillColor,
    required this.vibrantBlueColor,
    required this.surfaceMutedColor,
    required this.iconContainerColor,
    required this.avatarBackgroundColor,
    required this.pageBackgroundColor,
    required this.borderColor,
    required this.labelColor,
    required this.placeholderColor,
    required this.mutedTextColor,
    required this.secondaryTextColor,
    required this.tealAccentColor,
    required this.infoBackgroundColor,
    required this.infoBorderColor,
    required this.warningBackgroundColor,
    required this.warningColor,
    required this.inputTextColor,
    required this.bodyMutedColor,
    required this.cardBorderColor,
    required this.lightIconContainerColor,
    required this.secondaryBorderColor,
    required this.mutedHintColor,
    required this.starColor,
    required this.dividerColor,

    required this.headingLargeTextStyle,
    required this.headingTextStyle,
    required this.bodyLargeTextStyle,
    required this.bodyTextStyle,
    required this.buttonLabelTextStyle,
    required this.textFieldLabelTextStyle,
    required this.textFieldTextStyle,
    required this.textFieldHintTextStyle,
    required this.drawerLabelTextStyle,
    required this.descriptionSmallTextStyle,
    required this.popupMenuItemTextStyle,
    required this.infoLabelTextStyle,
    required this.overlineTextStyle, 
    required this.valueTextStyle, 
    required this.captionTextStyle,
    
    required this.textFieldBorder,
  });

  @override
  ThemeExtension<AppTheme> copyWith({
    Color? deepDarkBlueColor,
    Color? accentRedColor,
    Color? accentGreenColor,
    Color? surfaceColor,
    Color? accentBlueColor,
    Color? greyColor4,
    Color? greyColor6,
    Color? greyColor7,
    Color? cyanColor400,
    Color? softBlueColor,
    Color? fieldFillColor,
    Color? vibrantBlueColor,
    Color? surfaceMutedColor,
    Color? iconContainerColor,
    Color? avatarBackgroundColor,
    Color? pageBackgroundColor,
    Color? borderColor,
    Color? labelColor,
    Color? placeholderColor,
    Color? mutedTextColor,
    Color? secondaryTextColor,
    Color? tealAccentColor,
    Color? infoBackgroundColor,
    Color? infoBorderColor,
    Color? warningBackgroundColor,
    Color? warningColor,
    Color? inputTextColor,
    Color? bodyMutedColor,
    Color? cardBorderColor,
    Color? lightIconContainerColor,
    Color? secondaryBorderColor,
    Color? mutedHintColor,
    Color? starColor,
    Color? dividerColor,

    TextStyle? headingLargeTextStyle,
    TextStyle? headingTextStyle,
    TextStyle? bodyLargeTextStyle,
    TextStyle? bodyTextStyle,
    TextStyle? buttonLabelTextStyle,
    TextStyle? textFieldLabelTextStyle,
    TextStyle? textFieldHintTextStyle,
    TextStyle? textFieldTextStyle,
    TextStyle? drawerLabelTextStyle,
    TextStyle? descriptionSmallTextStyle,
    TextStyle? popupMenuItemTextStyle,
    TextStyle? infoLabelTextStyle,
    TextStyle? overlineTextStyle, 
    TextStyle? valueTextStyle, 
    TextStyle? captionTextStyle,

    InputBorder? textFieldBorder,
  }) {
    return AppTheme(
      deepDarkBlueColor: deepDarkBlueColor ?? this.deepDarkBlueColor,
      accentRedColor: accentRedColor ?? this.accentRedColor,
      accentGreenColor: accentGreenColor ?? this.accentGreenColor,
      accentBlueColor: accentBlueColor ?? this.accentBlueColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      greyColor4: greyColor4 ?? this.greyColor4,
      greyColor6: greyColor6 ?? this.greyColor6,
      greyColor7: greyColor7 ?? this.greyColor7,
      cyanColor400: cyanColor400 ?? this.cyanColor400,
      softBlueColor: softBlueColor ?? this.softBlueColor,
      fieldFillColor: fieldFillColor ?? this.fieldFillColor,
      vibrantBlueColor: vibrantBlueColor ?? this.vibrantBlueColor,
      surfaceMutedColor: surfaceMutedColor ?? this.surfaceMutedColor,
      iconContainerColor: iconContainerColor ?? this.iconContainerColor,
      avatarBackgroundColor: avatarBackgroundColor ?? this.avatarBackgroundColor,
      pageBackgroundColor: pageBackgroundColor ?? this.pageBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      labelColor: labelColor ?? this.labelColor,
      placeholderColor: placeholderColor ?? this.placeholderColor,
      mutedTextColor: mutedTextColor ?? this.mutedTextColor,
      secondaryTextColor: secondaryTextColor ?? this.secondaryTextColor,
      tealAccentColor: tealAccentColor ?? this.tealAccentColor,
      infoBackgroundColor: infoBackgroundColor ?? this.infoBackgroundColor,
      infoBorderColor: infoBorderColor ?? this.infoBorderColor,
      warningBackgroundColor:
          warningBackgroundColor ?? this.warningBackgroundColor,
      warningColor: warningColor ?? this.warningColor,
      inputTextColor: inputTextColor ?? this.inputTextColor,
      bodyMutedColor: bodyMutedColor ?? this.bodyMutedColor,
      cardBorderColor: cardBorderColor ?? this.cardBorderColor,
      lightIconContainerColor:
          lightIconContainerColor ?? this.lightIconContainerColor,
      secondaryBorderColor: secondaryBorderColor ?? this.secondaryBorderColor,
      mutedHintColor: mutedHintColor ?? this.mutedHintColor,
      starColor: starColor ?? this.starColor,
      dividerColor: dividerColor ?? this.dividerColor,

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
      descriptionSmallTextStyle:
          descriptionSmallTextStyle ?? this.descriptionSmallTextStyle,
      popupMenuItemTextStyle:
          popupMenuItemTextStyle ?? this.popupMenuItemTextStyle,
      infoLabelTextStyle: infoLabelTextStyle ?? this.infoLabelTextStyle,
      overlineTextStyle: overlineTextStyle ?? this.overlineTextStyle, 
      valueTextStyle: valueTextStyle ?? this.valueTextStyle, 
      captionTextStyle: captionTextStyle ?? this.captionTextStyle,

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
      accentGreenColor: Color.lerp(
        accentGreenColor,
        other.accentGreenColor,
        t,
      )!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      accentBlueColor: Color.lerp(accentBlueColor, other.accentBlueColor, t)!,
      greyColor4: Color.lerp(greyColor4, other.greyColor4, t)!,
      greyColor6: Color.lerp(greyColor6, other.greyColor6, t)!,
      greyColor7: Color.lerp(greyColor7, other.greyColor7, t)!,
      cyanColor400: Color.lerp(cyanColor400, other.cyanColor400, t)!,
      softBlueColor: Color.lerp(softBlueColor, other.softBlueColor, t)!,
      fieldFillColor: Color.lerp(fieldFillColor, other.fieldFillColor, t)!,
      vibrantBlueColor: Color.lerp(
        vibrantBlueColor,
        other.vibrantBlueColor,
        t,
      )!,
      surfaceMutedColor: Color.lerp(
        surfaceMutedColor,
        other.surfaceMutedColor,
        t,
      )!,
      iconContainerColor: Color.lerp(
        iconContainerColor,
        other.iconContainerColor,
        t,
      )!,
      avatarBackgroundColor: Color.lerp(
        avatarBackgroundColor,
        other.avatarBackgroundColor,
        t,
      )!,
      pageBackgroundColor: Color.lerp(
        pageBackgroundColor,
        other.pageBackgroundColor,
        t,
      )!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      labelColor: Color.lerp(labelColor, other.labelColor, t)!,
      placeholderColor: Color.lerp(
        placeholderColor,
        other.placeholderColor,
        t,
      )!,
      mutedTextColor: Color.lerp(mutedTextColor, other.mutedTextColor, t)!,
      secondaryTextColor: Color.lerp(
        secondaryTextColor,
        other.secondaryTextColor,
        t,
      )!,
      tealAccentColor: Color.lerp(
        tealAccentColor,
        other.tealAccentColor,
        t,
      )!,
      infoBackgroundColor: Color.lerp(
        infoBackgroundColor,
        other.infoBackgroundColor,
        t,
      )!,
      infoBorderColor: Color.lerp(
        infoBorderColor,
        other.infoBorderColor,
        t,
      )!,
      warningBackgroundColor: Color.lerp(
        warningBackgroundColor,
        other.warningBackgroundColor,
        t,
      )!,
      warningColor: Color.lerp(warningColor, other.warningColor, t)!,
      inputTextColor: Color.lerp(
        inputTextColor,
        other.inputTextColor,
        t,
      )!,
      bodyMutedColor: Color.lerp(
        bodyMutedColor,
        other.bodyMutedColor,
        t,
      )!,
      cardBorderColor: Color.lerp(
        cardBorderColor,
        other.cardBorderColor,
        t,
      )!,
      lightIconContainerColor: Color.lerp(
        lightIconContainerColor,
        other.lightIconContainerColor,
        t,
      )!,
      secondaryBorderColor: Color.lerp(
        secondaryBorderColor,
        other.secondaryBorderColor,
        t,
      )!,
      mutedHintColor: Color.lerp(
        mutedHintColor,
        other.mutedHintColor,
        t,
      )!,
      starColor: Color.lerp(starColor, other.starColor, t)!,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,

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
      descriptionSmallTextStyle: TextStyle.lerp(
        descriptionSmallTextStyle,
        other.descriptionSmallTextStyle,
        t,
      )!,
      popupMenuItemTextStyle: TextStyle.lerp(
        popupMenuItemTextStyle,
        other.popupMenuItemTextStyle,
        t,
      )!,
      infoLabelTextStyle: TextStyle.lerp(
        infoLabelTextStyle,
        other.infoLabelTextStyle,
        t,
      )!,
      overlineTextStyle: TextStyle.lerp(
        overlineTextStyle,
        other.overlineTextStyle,
        t,
      )!,
      valueTextStyle: TextStyle.lerp(
        valueTextStyle,
        other.valueTextStyle,
        t,
      )!,
      captionTextStyle: TextStyle.lerp(
        captionTextStyle,
        other.captionTextStyle,
        t,
      )!,

      textFieldBorder: textFieldBorder,
    );
  }
}
