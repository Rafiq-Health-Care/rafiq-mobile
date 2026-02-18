import 'package:flutter/material.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class TakeActionOrCancelButton extends StatelessWidget {
  final VoidCallback action;
  final VoidCallback? cancelAction;
  final String actionText;
  final String? cancelText;
  final Color? actionBackgroundColor;
  final Color? actionForegroundColor;
  final Color? cancelBackgroundColor;
  final Color? cancelForegroundColor;
  final TextStyle? actionTextStyle;
  final TextStyle? cancelTextStyle;

  const TakeActionOrCancelButton({
    super.key,
    required this.action,
    required this.actionText,
    this.cancelAction,
    this.cancelText,
    this.actionBackgroundColor,
    this.actionForegroundColor,
    this.cancelBackgroundColor,
    this.cancelForegroundColor,
    this.actionTextStyle,
    this.cancelTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CustomElevatedButton(
            onPressed: cancelAction ?? () => Navigator.pop(context),
            backgroundColor: cancelBackgroundColor ?? appTheme.surfaceColor,
            foregroundColor:
                cancelForegroundColor ?? appTheme.deepDarkBlueColor,
            child: Text(
              cancelText ?? 'Cancel',
              style: cancelTextStyle ?? appTheme.buttonLabelTextStyle,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          flex: 2,
          child: CustomElevatedButton(
            onPressed: action,
            backgroundColor:
                actionBackgroundColor ?? appTheme.deepDarkBlueColor,
            foregroundColor: actionForegroundColor ?? appTheme.surfaceColor,
            child: Text(
              actionText,
              style: actionTextStyle ?? appTheme.buttonLabelTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
