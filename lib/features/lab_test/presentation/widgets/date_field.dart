import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/lab_test/data/services/pick_date_service.dart';

class DateField extends StatelessWidget {
  final ValueNotifier<DateTime> dateNotifier;
  const DateField({super.key, required this.dateNotifier});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return ValueListenableBuilder<DateTime>(
      valueListenable: dateNotifier,
      builder: (context, date, _) {
        return InkWell(
          onTap: () async {
            final picked = await PickDateService().pickDate(context, date);
            if (picked != null) {
              dateNotifier.value = picked;
            }
          },
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: 'Test Date',
              prefixIcon: const Icon(Icons.calendar_today_outlined),
              border: appTheme.textFieldBorder,
              enabledBorder: appTheme.textFieldBorder,
              filled: true,
              fillColor: Colors.grey[50],
            ),
            child: Text(
              DateFormat('MM/dd/yyyy').format(date),
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
