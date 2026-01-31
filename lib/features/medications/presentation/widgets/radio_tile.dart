import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

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
    final theme = Theme.of(context).extension<AppTheme>()!;
    return RadioListTile<T>(
      title: Text(
        title,
        style: theme.bodyTextStyle.copyWith(color: theme.deepDarkBlueColor),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      contentPadding: EdgeInsets.zero,
      activeColor: theme.accentBlueColor,
      dense: true,
    );
  }
}
