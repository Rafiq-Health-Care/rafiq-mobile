import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/auth/data/models/password_validator.dart';

class PasswordRulesCard extends StatelessWidget {
  final PasswordValidator validator;
  const PasswordRulesCard({super.key, required this.validator});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    Color getColor(bool status) {
      return status ? appTheme.accentGreenColor : appTheme.accentRedColor;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: appTheme.fieldFillColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: getColor(validator.isValid)),
      ),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: 'Password strength :  ',
              style: appTheme.textFieldTextStyle.copyWith(fontSize: 14.sp),
              children: [
                TextSpan(
                  text: validator.isValid ? 'Strong' : 'Weak',
                  style: TextStyle(color: getColor(validator.isValid)),
                ),
                TextSpan(
                  text: '\t ${(validator.strength * 100).round()}%',
                  style: TextStyle(color: getColor(validator.isValid)),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: validator.strength,
            color: getColor(validator.isValid),
            borderRadius: BorderRadius.circular(8.r),
            backgroundColor: const Color(0xffE3E3E3),
            minHeight: 5.h,
          ),
          ...validator.rules.map((rule) {
            return Row(
              children: [
                Icon(
                  rule.isValid ? Icons.check_circle : Icons.cancel,
                  color: getColor(rule.isValid),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  rule.text,
                  style: appTheme.textFieldHintTextStyle.copyWith(
                    fontSize: 12.sp,
                    color: getColor(rule.isValid),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
