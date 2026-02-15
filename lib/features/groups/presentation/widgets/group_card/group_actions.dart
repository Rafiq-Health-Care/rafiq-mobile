import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/presentation/dialogs/confirmation_dialog.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/groups/data/models/group_content_model.dart';

class GroupActions extends StatelessWidget {
  final GroupContentModel group;
  const GroupActions({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          icon: Icon(Icons.edit, color: appTheme.deepDarkBlueColor, size: 22.r),
          onPressed: () {
            Navigator.pushNamed(
              context,
              RouterStrings.upsertGroup,
              arguments: group,
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.delete, color: appTheme.accentRedColor, size: 22.r),
          onPressed: () {
            showConfirmationDialog(
              context: context,
              title: 'Delete Group',
              content: 'Are you sure you want to delete "${group.name}"?',
              description:
                  '${group.medicineCount} medicines will be ungrouped but not deleted.\nThis action cannot be undone.',
              onConfirm: () {
                GroupCubit.of(context).deleteGroup(group.id);
              },
            );
          },
        ),
      ],
    );
  }
}
