import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class PickDateService {
  Future<DateTime?> pickDate(BuildContext context, DateTime initialDate) async {
    final appTheme = context.appTheme;
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(primary: appTheme.deepDarkBlueColor),
          ),
          child: child!,
        );
      },
    );
  }
}
