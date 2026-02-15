import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_icon_button.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';

class FileActionsButton extends StatelessWidget {
  final VoidCallback onClickDownload;
  final VoidCallback onClickUpdate;
  final VoidCallback onClickDelete;

  const FileActionsButton({
    super.key,
    required this.onClickDownload,
    required this.onClickDelete,
    required this.onClickUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: CustomIconButton(
            onPress: onClickDownload,
            label: 'Download File',
            icon: Icons.download,
          ),
        ),
        SizedBox(width: 2),
        Material(
          color: appTheme.deepDarkBlueColor,
          borderRadius: BorderRadius.circular(12),
          child: IconButton(
            padding: EdgeInsets.zero,
            onPressed: onClickUpdate,
            icon: Icon(Icons.edit, color: appTheme.surfaceColor, size: 30),
          ),
        ),
        BlocListener<LabTestCubit, LabTestState>(
          listener: (context, state) {
            if (state is LabTestSuccess) {
              Navigator.pop(context);
            } else if (state is LabTestError) {
              snackBarMessage(context, state.message);
            }
          },
          child: Material(
            color: appTheme.surfaceColor,
            borderRadius: BorderRadius.circular(12),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.delete,
                color: appTheme.accentRedColor,
                size: 30,
              ),
              onPressed: onClickDelete,
            ),
          ),
        ),
      ],
    );
  }
}
