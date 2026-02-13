import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomToggleSwitch<T> extends StatelessWidget {
  final ValueNotifier<T> valueNotifier;
  final String title;
  final T trueValue;
  final T falseValue;

  const CustomToggleSwitch({
    super.key,
    required this.valueNotifier,
    required this.title,
    required this.trueValue,
    required this.falseValue,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: appTheme.headingTextStyle.copyWith(fontSize: 16)),
        ValueListenableBuilder(
          valueListenable: valueNotifier,
          builder: (context, value, child) {
            return Switch(
              value: value == trueValue,
              onChanged: (val) {
                valueNotifier.value = val ? trueValue : falseValue;
              },
              activeColor: appTheme.surfaceColor,
              activeTrackColor: const Color(0xFF2C6ECB),
              inactiveTrackColor: appTheme.greyColor7,
              inactiveThumbColor: appTheme.surfaceColor,
              thumbIcon: WidgetStatePropertyAll(
                Icon(Icons.circle, color: appTheme.surfaceColor),
              ),
            );
          },
        ),
      ],
    );
  }
}
