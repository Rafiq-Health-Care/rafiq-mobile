import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rafiq/core/services/date_time_service.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/opacity_extension.dart';

class DoseTimeManager extends StatelessWidget {
  final ValueNotifier<List<TimeOfDay>> doseTimes;
  const DoseTimeManager({super.key, required this.doseTimes});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<TimeOfDay>>(
      valueListenable: doseTimes,
      builder: (context, times, _) {
        return Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            ...times.map(
              (time) => TimeChip(
                time: time,
                onDelete: () {
                  if (times.length > 1) {
                    final newTimes = List<TimeOfDay>.from(times)..remove(time);
                    doseTimes.value = newTimes;
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('At least one dose time is required.'),
                      ),
                    );
                  }
                },
              ),
            ),
            AddDoseButton(
              onAdd: (time) {
                if (!times.contains(time)) {
                  final newTimes = List<TimeOfDay>.from(times)..add(time);
                  newTimes.sort((a, b) {
                    int compare = a.hour.compareTo(b.hour);
                    if (compare == 0) return a.minute.compareTo(b.minute);
                    return compare;
                  });
                  doseTimes.value = newTimes;
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class TimeChip extends StatelessWidget {
  final TimeOfDay time;
  final VoidCallback onDelete;
  const TimeChip({super.key, required this.time, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: appTheme.deepDarkBlueColor.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: appTheme.accentBlueColor.withValues(alpha:0.2)),
      ),
      child: Row(
        spacing: 10.w,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.access_time_filled_rounded,
            size: 20.r,
            color: appTheme.vibrantBlueColor,
          ),
          Text(
            time.format(context),
            style: appTheme.bodyTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: appTheme.deepDarkBlueColor,
              fontSize: 15.sp,
            ),
          ),
          GestureDetector(
            onTap: onDelete,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: appTheme.accentRedColor.withValues(alpha:0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                size: 14.r,
                color: appTheme.accentRedColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddDoseButton extends StatelessWidget {
  final Function(TimeOfDay) onAdd;
  const AddDoseButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return GestureDetector(
      onTap: () async {
        final picked = await DateTimeService().pickTime(context);
        if (picked != null) onAdd(picked);
      },
      child: DottedBorder(
        options: RoundedRectDottedBorderOptions(
          radius: Radius.circular(16.r),
          strokeWidth: 1.5,
          color: appTheme.deepDarkBlueColor.withValues(alpha: 0.3),
          dashPattern: const [6, 4],
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_rounded,
                size: 20.r,
                color: appTheme.deepDarkBlueColor,
              ),
              SizedBox(width: 6.w),
              Text(
                'Add Dose',
                style: appTheme.bodyTextStyle.copyWith(
                  fontWeight: FontWeight.w700,
                  color: appTheme.deepDarkBlueColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ).withOpacity(0.5);
  }
}
