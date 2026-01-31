import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/widgets/selected_action_button.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';
import 'package:rafiq/features/medications/controllers/selected_medication_cubit/selected_medication_cubit.dart';
import 'package:rafiq/core/widgets/move_to_group_button.dart';

class SelectionModeActions extends StatelessWidget {
  final VoidCallback onInactive;
  final VoidCallback onActive;
  final VoidCallback onDelete;
  final Function(GroupContentModel) onMoveToGroup;

  const SelectionModeActions({
    super.key,
    required this.onInactive,
    required this.onActive,
    required this.onDelete,
    required this.onMoveToGroup,
  });

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
                onTap: () => onInactive(),
                child: SelectedActionButton(
                  title: 'Inactive',
                  icon: Icons.circle,
                  iconColor: Colors.grey,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => onActive(),
                child: SelectedActionButton(
                  title: 'Active',
                  icon: Icons.circle,
                  iconColor: Colors.green,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => onDelete(),
                child: SelectedActionButton(
                  title: 'Delete',
                  icon: Icons.delete,
                  iconColor: Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              MoveToGroupButton(onMoveToGroup: onMoveToGroup),
            ],
          ),
        ),
      ],
    );
  }
}
