import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/widgets/selected_action_button.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/core/presentation/dialogs/delete_confirmation_dialog.dart';
import 'package:rafiq/features/medications/data/enums/medicine_bulk_actions_enum.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';
import 'package:rafiq/features/medications/presentation/widgets/move_to_group_button.dart';

class SelectionModeActions extends StatelessWidget {
  final List<String> medicineIds;
  const SelectionModeActions({super.key, required this.medicineIds});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        BlocBuilder<SelectedMedicationCubit, Set<String>>(
          builder: (context, selectionState) {
            return Text(
              '${selectionState.length} Items Selected',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            );
          },
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              GestureDetector(
                onTap: () {
                  MedicationCubit.of(context).bulkMedicines(
                    MedicinesBulkRequest(
                      medicineIds: medicineIds,
                      action: MedicineBulkActionsEnum.markInactive,
                    ),
                  );
                  SelectedMedicationCubit.of(context).clearSelection();
                },
                child: SelectedActionButton(
                  title: 'Inactive',
                  icon: Icons.circle,
                  iconColor: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  MedicationCubit.of(context).bulkMedicines(
                    MedicinesBulkRequest(
                      medicineIds: medicineIds,
                      action: MedicineBulkActionsEnum.markActive,
                    ),
                  );
                  SelectedMedicationCubit.of(context).clearSelection();
                },
                child: SelectedActionButton(
                  title: 'Active',
                  icon: Icons.circle,
                  iconColor: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  showDeleteConfirmationDialog(
                    context: context,
                    title: 'Confirm Deletion',
                    content:
                        'Are you sure you want to permanently delete Selected medicines?',
                    description:
                        'This action cannot be undone. All related data will be removed.',
                    onConfirm: () {
                      MedicationCubit.of(context).bulkMedicines(
                        MedicinesBulkRequest(
                          medicineIds: medicineIds,
                          action: MedicineBulkActionsEnum.delete,
                        ),
                      );
                      SelectedMedicationCubit.of(context).clearSelection();
                    },
                  );
                },
                child: SelectedActionButton(
                  title: 'Delete',
                  icon: Icons.delete,
                  iconColor: Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              MoveToGroupButton(selectionState: medicineIds),
            ],
          ),
        ),
      ],
    );
  }
}
