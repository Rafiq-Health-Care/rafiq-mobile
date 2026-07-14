import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/medications/presentation/enums/schedule_frequency.dart';

class FrequencySelector extends StatelessWidget {
  final ValueNotifier<ScheduleFrequency> selectedFrequency;
  const FrequencySelector({super.key, required this.selectedFrequency});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return ValueListenableBuilder<ScheduleFrequency>(
      valueListenable: selectedFrequency,
      builder: (context, current, _) {
        return Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: appTheme.fieldFillColor,
            borderRadius: BorderRadius.circular(18.r),
          ),
          padding: EdgeInsets.all(5.w),
          child: Row(
            children: ScheduleFrequency.values.map((freq) {
              final isSelected = current == freq;
              return Expanded(
                child: GestureDetector(
                  onTap: () => selectedFrequency.value = freq,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? appTheme.vibrantBlueColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(14.r),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: appTheme.deepDarkBlueColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      freq.name.toUpperCase(),
                      style: appTheme.buttonLabelTextStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : appTheme.deepDarkBlueColor.withValues(alpha: 0.5),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
