import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/services/date_time_service.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/picker_field.dart';

class SessionDateTimeRow extends StatelessWidget {
  final ValueNotifier<DateTime> dateNotifier;
  final ValueNotifier<TimeOfDay> timeNotifier;

  const SessionDateTimeRow({
    super.key,
    required this.dateNotifier,
    required this.timeNotifier,
  });

  Future<void> _pickDate(BuildContext context) async {
    final dateTimeService = DateTimeService();
    final picked = await dateTimeService.pickDate(context, dateNotifier.value);
    if (picked != null) dateNotifier.value = picked;
  }

  Future<void> _pickTime(BuildContext context) async {
    final dateTimeService = DateTimeService();
    final picked = await dateTimeService.pickTime(
      context,
      time: timeNotifier.value,
    );
    if (picked != null) timeNotifier.value = picked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ValueListenableBuilder<DateTime>(
            valueListenable: dateNotifier,
            builder: (context, date, _) {
              return PickerField(
                label: 'Session Date',
                value: DateFormat('MMM d, yyyy').format(date),
                icon: Icons.calendar_today_outlined,
                onTap: () => _pickDate(context),
              );
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: ValueListenableBuilder<TimeOfDay>(
            valueListenable: timeNotifier,
            builder: (context, time, _) {
              return PickerField(
                label: 'Start Time',
                value: DateTimeService().formatTimeOfDay(time),
                icon: Icons.access_time,
                onTap: () => _pickTime(context),
              );
            },
          ),
        ),
      ],
    );
  }
}
