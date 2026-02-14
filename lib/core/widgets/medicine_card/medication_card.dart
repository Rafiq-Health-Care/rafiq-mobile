import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';
import 'package:rafiq/core/widgets/medicine_card/medication_card_details.dart';
import 'package:rafiq/core/widgets/medicine_card/medication_card_footer.dart';
import 'package:rafiq/core/widgets/medicine_card/medication_card_header.dart';

class MedicationCard extends StatelessWidget {
  final AllMedicinesContentModel medication;
  const MedicationCard({super.key, required this.medication});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppTheme>()!;

    return BlocSelector<SelectedMedicationCubit, Set<String>, bool>(
      selector: (state) {
        return state.contains(medication.id);
      },
      builder: (context, isSelected) {
        final isSelectionMode = SelectedMedicationCubit.of(
          context,
        ).state.isNotEmpty;

        return GestureDetector(
          onLongPress: () {
            SelectedMedicationCubit.of(context).toggleSelection(medication.id);
          },
          onTap: () {
            if (isSelectionMode) {
              SelectedMedicationCubit.of(
                context,
              ).toggleSelection(medication.id);
            } else {
              Navigator.of(context).pushNamed(
                RouterStrings.medicationDetails,
                arguments: medication.id,
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0XFFD6E7FF) : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? theme.accentBlueColor
                    : Colors.grey.shade300,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MedicationCardHeader(
                  medication: medication,
                  isSelectionMode: isSelectionMode,
                  isSelected: isSelected,
                  onSelectionToggle: () {
                    SelectedMedicationCubit.of(
                      context,
                    ).toggleSelection(medication.id);
                  },
                ),
                const SizedBox(height: 12),
                MedicationCardDetails(
                  frequency: medication.frequency,
                  nextReminder: medication.nextReminder,
                ),
                const SizedBox(height: 16),
                MedicationCardFooter(status: medication.status),
              ],
            ),
          ),
        );
      },
    );
  }
}
