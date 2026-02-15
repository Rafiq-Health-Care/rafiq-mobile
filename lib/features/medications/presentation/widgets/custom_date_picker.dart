import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/services/date_time_service.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final ValueNotifier<DateTime?> dateNotifier;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.dateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
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
              final pickedDate = await DateTimeService().pickDate(
                context,
                dateNotifier.value,
              );
              if (pickedDate != null) {
                dateNotifier.value = pickedDate;
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
                    valueListenable: dateNotifier,
                    builder: (context, value, child) {
                      return Text(
                        value != null
                            ? DateFormat('dd/MM/yyyy').format(value)
                            : 'dd/mm/yyyy',
                        style: appTheme.textFieldTextStyle.copyWith(
                          color: const Color(0xff848484),
                          fontSize: 14.sp,
                        ),
                      );
                    },
                  ),
                  Icon(Icons.calendar_today, size: 15.r),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
