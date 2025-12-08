import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/widgets/custom_icon_button.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';

class DownloadDeleteButtons extends StatelessWidget {
  final VoidCallback onClickDownload;
  final VoidCallback onClickDelete;

  const DownloadDeleteButtons({
    super.key,
    required this.onClickDownload,
    required this.onClickDelete,
  });

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = Theme.of(context).extension<AppTheme>()!;
    return Row(
      spacing: 16,
      children: [
        Expanded(
          child: CustomIconButton(
            onPress: onClickDownload,
            label: 'Download File',
            icon: Icons.download,
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
          child: IconButton(
            icon: Icon(Icons.delete, color: appTheme.accentRedColor, size: 30),
            onPressed: onClickDelete,
          ),
        ),
      ],
    );
  }
}
