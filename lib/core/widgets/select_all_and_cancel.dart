import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/features/medications/data/models/all_medicines_content_model.dart';

class SelectAllAndCancel extends StatelessWidget {
  final List<AllMedicinesContentModel> medications;
  const SelectAllAndCancel({super.key, required this.medications});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          BlocSelector<SelectedMedicationCubit, Set<String>, bool>(
            selector: (selectionState) =>
                selectionState.length == medications.length,
            builder: (context, isSelectAll) {
              return Checkbox(
                value: isSelectAll,
                activeColor: appTheme.accentBlueColor,
                onChanged: (value) {
                  if (value == true) {
                    SelectedMedicationCubit.of(
                      context,
                    ).selectAll(medications.map((e) => e.id).toList());
                  } else {
                    SelectedMedicationCubit.of(context).clearSelection();
                  }
                },
              );
            },
          ),
          const Text('Select all'),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              SelectedMedicationCubit.of(context).clearSelection();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: appTheme.accentBlueColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Cancel Selection',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
