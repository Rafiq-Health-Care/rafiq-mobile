import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/take_action_or_cancel_button.dart';

void showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  required String description,
  required VoidCallback onConfirm,
  String confirmLabel = 'Confirm Delete',
  String cancelLabel = 'Cancel',
  Color iconBGColor = const Color(0XFFFFE0E0),
  Color iconColor = const Color(0XFFF04040),
}) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      final appTheme = context.appTheme;
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: appTheme.surfaceColor,
        contentPadding: const EdgeInsets.all(24),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: iconBGColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: iconColor,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: appTheme.headingTextStyle.copyWith(
                fontSize: 22,
                color: appTheme.deepDarkBlueColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: appTheme.bodyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: appTheme.deepDarkBlueColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: appTheme.descriptionSmallTextStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            TakeActionOrCancelButton(
              action: () {
                onConfirm();
                Navigator.of(dialogContext).pop();
              },
              actionText: confirmLabel,
              cancelText: cancelLabel,
              cancelBackgroundColor: appTheme.softBlueColor,
              cancelForegroundColor: appTheme.deepDarkBlueColor,
              cancelTextStyle: appTheme.buttonLabelTextStyle.copyWith(
                color: appTheme.deepDarkBlueColor,
              ),
            ),
          ],
        ),
      );
    },
  );
}
