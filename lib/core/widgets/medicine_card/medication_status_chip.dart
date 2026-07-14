import 'package:flutter/material.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';

class MedicationStatusChip extends StatelessWidget {
  final MedicineStatusEnum status;
  const MedicationStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    Color labelColor;
    String label;
    IconData icon;

    switch (status) {
      case MedicineStatusEnum.active:
        color = Colors.green.shade100;
        labelColor = Colors.green.shade800;
        label = 'Active';
        icon = Icons.circle;
        break;
      case MedicineStatusEnum.discontinued:
        color = Colors.grey.shade200;
        labelColor = Colors.grey.shade700;
        label = 'Discontinued';
        icon = Icons.circle;
        break;
      case MedicineStatusEnum.inactive:
        color = Colors.red.shade100;
        label = 'Inactive';
        labelColor = Colors.red.shade800;
        icon = Icons.circle;
        break;
      case MedicineStatusEnum.all:
        color = Colors.blue.shade100;
        labelColor = Colors.blue.shade800;
        label = 'Unknown';
        icon = Icons.circle;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 10,
            color: labelColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: labelColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
