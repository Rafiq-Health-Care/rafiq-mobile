import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> items;
  final ValueNotifier<T> valueNotifier;
  final double? iconSize;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.valueNotifier,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return ValueListenableBuilder<T>(
      valueListenable: valueNotifier,
      builder: (context, value, child) {
        return DropdownButtonFormField<T>(
          value: value,
          decoration: InputDecoration(
            border: appTheme.textFieldBorder,
            enabledBorder: appTheme.textFieldBorder,
            focusedBorder: appTheme.textFieldBorder.copyWith(
              borderSide: BorderSide(
                color: appTheme.deepDarkBlueColor,
                width: 1.5,
              ),
            ),
            filled: true,
            fillColor: appTheme.fieldFillColor,
          ),
          menuMaxHeight: 240.h,
          iconSize: iconSize ?? 24.r,
          dropdownColor: appTheme.surfaceColor,
          borderRadius: BorderRadius.circular(16),
          items: items,
          onChanged: (val) {
            if (val != null) valueNotifier.value = val;
          },
        );
      },
    );
  }
}
