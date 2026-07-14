import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class TextWithActionLink extends StatelessWidget {
  final String staticText;
  final String linkText;
  final VoidCallback onTap;
  final TextStyle? staticTextStyle;
  final TextStyle? linkTextStyle;

  const TextWithActionLink({
    super.key,
    required this.staticText,
    required this.linkText,
    required this.onTap,
    this.staticTextStyle,
    this.linkTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(staticText, style: staticTextStyle),
        GestureDetector(
          onTap: onTap,
          child: Text(linkText, style: linkTextStyle ?? appTheme.bodyTextStyle),
        ),
      ],
    );
  }
}
