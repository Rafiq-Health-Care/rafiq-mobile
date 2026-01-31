import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/core/widgets/medicine_card/medication_status_chip.dart';

class MedicationCardFooter extends StatelessWidget {
  final MedicineStatusEnum status;

  const MedicationCardFooter({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MedicationStatusChip(status: status),
        Row(
          children: [
            Icon(Icons.list, color: Colors.grey.shade500),
            const SizedBox(width: 12),
            Icon(Icons.edit, color: Colors.grey.shade500),
            const SizedBox(width: 12),
            Icon(Icons.delete, color: theme.accentRedColor),
          ],
        ),
      ],
    );
  }
}
