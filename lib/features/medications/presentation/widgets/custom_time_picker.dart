import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/services/date_time_service.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class CustomTimePicker extends StatelessWidget {
  final String label;
  final ValueNotifier<TimeOfDay> timeNotifier;
  const CustomTimePicker({
    super.key,
    required this.timeNotifier,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: appTheme.textFieldLabelTextStyle.copyWith(fontSize: 15.sp),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () async {
              final pickedTime = await DateTimeService().pickTime(
                context,
                timeNotifier.value,
              );
              if (pickedTime != null) {
                timeNotifier.value = pickedTime;
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(
                  color: appTheme.textFieldBorder.borderSide.color,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                    valueListenable: timeNotifier,
                    builder: (context, value, child) {
                      return Text(
                        DateTimeService().formatTimeOfDay(value),
                        style: appTheme.textFieldTextStyle.copyWith(
                          color: const Color(0xff848484),
                          fontSize: 14.sp,
                        ),
                      );
                    },
                  ),
                  Icon(Icons.access_time, size: 15.r),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
