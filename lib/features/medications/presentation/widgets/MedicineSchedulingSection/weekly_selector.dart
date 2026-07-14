import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/medications/presentation/enums/week_days.dart';

class WeeklySelector extends StatelessWidget {
  final ValueNotifier<List<WeekDays>> selectedDays;
  const WeeklySelector({super.key, required this.selectedDays});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SELECT WEEK DAYS',
          style: appTheme.textFieldLabelTextStyle.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        SizedBox(height: 16.h),
        ValueListenableBuilder<List<WeekDays>>(
          valueListenable: selectedDays,
          builder: (context, days, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: WeekDays.values.map((day) {
                final isSelected = days.contains(day);
                return GestureDetector(
                  onTap: () {
                    final newList = List<WeekDays>.from(days);
                    if (newList.contains(day)) {
                      if (newList.length > 1) newList.remove(day);
                    } else {
                      newList.add(day);
                    }
                    selectedDays.value = newList;
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: 45.w,
                    height: 45.w,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? appTheme.vibrantBlueColor
                          : Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? appTheme.vibrantBlueColor
                            : appTheme.greyColor4,
                        width: 1.5,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: appTheme.vibrantBlueColor.withValues(
                                  alpha: 0.3,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ]
                          : [],
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      day.name[0].toUpperCase(),
                      style: appTheme.bodyTextStyle.copyWith(
                        color: isSelected
                            ? Colors.white
                            : appTheme.deepDarkBlueColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 16.sp,
                      ),
                    ),
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
