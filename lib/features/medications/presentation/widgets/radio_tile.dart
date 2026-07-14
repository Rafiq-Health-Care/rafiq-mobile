import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class RadioTile<T> extends StatelessWidget {
  final String title;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;

  const RadioTile({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return RadioListTile<T>(
      title: Text(
        title,
        style: appTheme.bodyTextStyle.copyWith(
          color: appTheme.deepDarkBlueColor,
        ),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeColor: appTheme.accentBlueColor,
      dense: true,
    );
  }
}
