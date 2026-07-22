import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

/// Multi-select chips over a fixed list of options (e.g. languages).
class ChipMultiSelect extends StatelessWidget {
  final String label;
  final List<String> options;
  final List<String> selected;
  final ValueChanged<List<String>> onChanged;

  const ChipMultiSelect({
    super.key,
    required this.label,
    required this.options,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(label, style: appTheme.textFieldLabelTextStyle),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: options.map((option) {
            final isSelected = selected.contains(option);
            return FilterChip(
              label: Text(option.toReadableFormat()),
              selected: isSelected,
              onSelected: (value) {
                final updated = List<String>.from(selected);
                if (value) {
                  updated.add(option);
                } else {
                  updated.remove(option);
                }
                onChanged(updated);
              },
              selectedColor: appTheme.deepDarkBlueColor.withValues(
                alpha: 0.15,
              ),
              checkmarkColor: appTheme.deepDarkBlueColor,
              labelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? appTheme.deepDarkBlueColor
                    : appTheme.greyColor7,
              ),
              backgroundColor: appTheme.fieldFillColor,
              side: BorderSide(
                color: isSelected
                    ? appTheme.deepDarkBlueColor
                    : appTheme.greyColor4,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
