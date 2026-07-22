import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';

class FeedbackCommentField extends StatelessWidget {
  final TextEditingController controller;

  const FeedbackCommentField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return CustomLabeledTextField(
      label: 'WRITE A REVIEW (OPTIONAL)',
      labelTextStyle: appTheme.overlineTextStyle.copyWith(
        fontFamily: 'Manrope',
        fontSize: 12.sp,
        letterSpacing: 0.6,
        color: appTheme.bodyMutedColor,
      ),
      fillColor: appTheme.lightIconContainerColor,
      hint: 'Tell us more about your consultation...',
      controller: controller,
      textFieldTextStyle: TextStyle(
        fontFamily: 'Manrope',
        fontSize: 14.sp,
        color: appTheme.inputTextColor,
      ),
      height: 140.h,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
