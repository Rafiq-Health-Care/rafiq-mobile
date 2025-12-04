import 'package:flutter/material.dart';
import 'package:rafiq/core/theme/app_theme.dart';

class PickedFileInfoCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onCancel;

  const PickedFileInfoCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          Icons.insert_drive_file,
          color: appTheme.deepDarkBlueColor,
        ),
        title: Text(title),
        subtitle: Text('$subTitle bytes'),
        trailing: IconButton(
          icon: Icon(Icons.close, color: appTheme.accentRedColor),
          onPressed: onCancel,
        ),
      ),
    );
  }
}
