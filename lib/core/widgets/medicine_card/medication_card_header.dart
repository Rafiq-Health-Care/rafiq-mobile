import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';

class MedicationCardHeader extends StatelessWidget {
  final AllMedicinesContentModel medication;
  final bool isSelectionMode;
  final bool isSelected;
  final VoidCallback onSelectionToggle;

  const MedicationCardHeader({
    super.key,
    required this.medication,
    required this.isSelectionMode,
    required this.isSelected,
    required this.onSelectionToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Text(
            medication.name,
            style: theme.headingTextStyle.copyWith(fontSize: 20),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        if (medication.groupName != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.link, size: 14, color: Colors.orange.shade800),
                const SizedBox(width: 4),
                Text(
                  medication.groupName!,
                  style: TextStyle(
                    color: Colors.orange.shade800,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        if (isSelectionMode)
          Checkbox(
            value: isSelected,
            onChanged: (value) => onSelectionToggle(),
            activeColor: theme.accentBlueColor,
          )
        else
          Icon(Icons.notifications, color: theme.accentBlueColor, size: 20),
      ],
    );
  }
}
