import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/widgets/custom_popup_menu_button.dart';
import 'package:rafiq/core/widgets/selected_action_button.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/features/medications/data/enums/medicine_bulk_actions_enum.dart';
import 'package:rafiq/features/medications/data/models/medicines_bulk_request.dart';

class MoveToGroupButton extends StatelessWidget {
  final List<String> selectionState;
  const MoveToGroupButton({super.key, required this.selectionState});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, state) {
        return CustomPopupMenuButton<GroupContentModel>(
          items: state is GroupLoaded
              ? state.allGroups.map((group) {
                  return PopupMenuItem(
                    value: group,
                    child: Text(
                      group.name,
                      style: appTheme.popupMenuItemTextStyle,
                    ),
                  );
                }).toList()
              : [],
          onSelected: (value) {
            MedicationCubit.of(context).bulkMedicines(
              MedicinesBulkRequest(
                medicineIds: selectionState,
                action: MedicineBulkActionsEnum.moveToGroup,
                groupId: value.id,
              ),
            );
            SelectedMedicationCubit.of(context).clearSelection();
          },
          child: SelectedActionButton(
            title: 'Move To',
            icon: Icons.drive_file_move,
            iconColor: Colors.grey.shade700,
          ),
        );
      },
    );
  }
}
