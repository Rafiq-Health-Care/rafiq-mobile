import 'package:flutter/material.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/core/widgets/medicine_card/medication_status_chip.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class MedicationCardFooter extends StatelessWidget {
  final MedicineStatusEnum status;
  const MedicationCardFooter({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MedicationStatusChip(status: status),
        Row(
          spacing: 12,
          children: [
            Icon(Icons.list, color: Colors.grey.shade500),
            Icon(Icons.edit, color: Colors.grey.shade500),
            Icon(Icons.delete, color: appTheme.accentRedColor),
          ],
        ),
      ],
    );
  }
}
