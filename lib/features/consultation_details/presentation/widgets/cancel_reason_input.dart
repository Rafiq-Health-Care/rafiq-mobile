// cancel_reason_input.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CancelReasonInput extends StatelessWidget {
  final TextEditingController controller;
  const CancelReasonInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final theme = context.appTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CANCEL REASON (OPTIONAL)', style: theme.overlineTextStyle),
        SizedBox(height: 8.h),
        TextField(
          controller: controller,
          minLines: 2,
          maxLines: 4,
          style: theme.textFieldTextStyle.copyWith(fontSize: 14.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: theme.textFieldBorder,
            enabledBorder: theme.textFieldBorder,
            focusedBorder: theme.textFieldBorder,
            filled: true,
            fillColor: theme.fieldFillColor,
            hintText: 'If canceling, please provide a brief reason for the patient...',
            hintStyle: theme.textFieldHintTextStyle,
          ),
        ),
      ],
    );
  }
}