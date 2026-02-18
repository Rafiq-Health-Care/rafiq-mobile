import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class ColorPicker extends StatelessWidget {
  final ValueNotifier<Color> selectedColorNotifier;
  final List<Color> colors;

  const ColorPicker({
    super.key,
    required this.selectedColorNotifier,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      spacing: 8,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Color', style: appTheme.textFieldLabelTextStyle),
        ValueListenableBuilder<Color>(
          valueListenable: selectedColorNotifier,
          builder: (context, selectedColor, _) {
            return Wrap(
              spacing: 8.r,
              runSpacing: 8.r,
              children: colors.map((color) {
                final isSelected = color.toARGB32() == selectedColor.toARGB32();
                return GestureDetector(
                  onTap: () => selectedColorNotifier.value = color,
                  child: Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.6),
                          blurRadius: 4,
                          offset: const Offset(-.8, 2),
                        ),
                      ],
                    ),
                    child: isSelected
                        ? Icon(
                            Icons.check,
                            color: appTheme.surfaceColor,
                            size: 28.r,
                          )
                        : null,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
