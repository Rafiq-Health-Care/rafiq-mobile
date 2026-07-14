import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_popup_menu_button.dart';
import 'package:rafiq/core/widgets/selected_action_button.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';

class MoveToGroupButton extends StatelessWidget {
  final Function(GroupContentModel) onMoveToGroup;
  const MoveToGroupButton({super.key, required this.onMoveToGroup});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

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
          onSelected: (value) => onMoveToGroup(value),
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
