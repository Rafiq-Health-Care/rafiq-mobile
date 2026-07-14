import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class DateTimeService {
  static final DateTimeService _instance = DateTimeService._();
  factory DateTimeService() => _instance;
  DateTimeService._();

  Future<DateTime?> pickDate(BuildContext context, DateTime? date) async {
    return await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
      builder: (context, child) {
        final appTheme = context.appTheme;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appTheme.deepDarkBlueColor,
              onPrimary: appTheme.surfaceColor,
              onSurface: appTheme.deepDarkBlueColor,
              surface: appTheme.surfaceColor,
              secondary: appTheme.softBlueColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: appTheme.deepDarkBlueColor,
                textStyle: appTheme.buttonLabelTextStyle,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  Future<TimeOfDay?> pickTime(BuildContext context, {TimeOfDay? time}) async {
    return await showTimePicker(
      context: context,
      initialTime: time ?? TimeOfDay.now(),
      builder: (context, child) {
        final appTheme = context.appTheme;
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: appTheme.deepDarkBlueColor,
              onPrimary: appTheme.surfaceColor,
              onSurface: appTheme.deepDarkBlueColor,
              surface: appTheme.surfaceColor,
              secondary: appTheme.softBlueColor,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: appTheme.deepDarkBlueColor,
                textStyle: appTheme.buttonLabelTextStyle,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // 09:00 PM
    return format.format(dt);
  }
}
