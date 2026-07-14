import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class CustomLabeledTextField extends StatelessWidget {
  final String? label;
  final String hint;
  final bool isOptional;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? prefixText;
  final double? height;
  final Widget? prefixIcon;
  final Widget? labelIcon;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final TextStyle? labelTextStyle;
  final Color? fillColor;

  const CustomLabeledTextField( {
    super.key,
    required this.hint,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.label,
    this.isOptional = false,
    this.inputFormatters,
    this.prefixText,
    this.height,
    this.prefixIcon,
    this.labelIcon,
    this.onChanged,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
    this.labelTextStyle,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final bool isTextArea = height != null;
    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (labelIcon != null) labelIcon!,
            if (label != null)
              Text(
                label!,
                style: labelTextStyle ?? appTheme.textFieldLabelTextStyle,
              ),
            if (isOptional)
              Text(
                '(Optional)',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: appTheme.greyColor4,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        SizedBox(
          height: height,
          child: TextFormField(
            controller: controller,
            validator: validator,
            onChanged: onChanged,
            focusNode: focusNode,
            textAlignVertical: TextAlignVertical.top,
            decoration: InputDecoration(
              hintText: hint,
              prefixText: prefixText,
              prefixStyle: appTheme.textFieldTextStyle,
              border: appTheme.textFieldBorder,
              enabledBorder: appTheme.textFieldBorder,
              focusedBorder: appTheme.textFieldBorder.copyWith(
                borderSide: BorderSide(
                  color: appTheme.deepDarkBlueColor,
                  width: 1.5,
                ),
              ),
              hintStyle: appTheme.textFieldHintTextStyle,
              fillColor: fillColor ?? appTheme.fieldFillColor,
              filled: true,
              prefixIcon: prefixIcon,
            ),
            style: appTheme.textFieldTextStyle,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            expands: isTextArea,
            maxLines: isTextArea ? null : 1,
            textInputAction: textInputAction,
            onFieldSubmitted: onFieldSubmitted,
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
          ),
        ),
      ],
    );
  }
}
