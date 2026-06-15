import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';

class MedicationDetailsHeader extends StatelessWidget {
  final String medicineName;
  final MedicineStatusEnum status;

  const MedicationDetailsHeader({
    super.key,
    required this.medicineName,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final isActive = status == MedicineStatusEnum.active;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                medicineName,
                style: appTheme.headingTextStyle.copyWith(
                  fontSize: 28,
                  color: appTheme.deepDarkBlueColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: isActive ? Colors.green.shade50 : Colors.red.shade50,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 8,
                    color: isActive ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isActive ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: isActive ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Details for your medication record.',
          style: appTheme.descriptionSmallTextStyle,
        ),
      ],
    );
  }
}
