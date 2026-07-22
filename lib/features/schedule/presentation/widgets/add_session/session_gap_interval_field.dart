import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_dropdown_button.dart';

class SessionGapIntervalField extends StatelessWidget {
  final ValueNotifier<int> gapMinutesNotifier;

  const SessionGapIntervalField({super.key, required this.gapMinutesNotifier});

  static const _options = [0, 5, 10, 15, 20, 30];

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropdownButton<int>(
          label: 'Gap Interval (After Session)',
          labelSize: 14.sp,
          valueNotifier: gapMinutesNotifier,
          items: _options
              .map(
                (m) => DropdownMenuItem(
                  value: m,
                  child: Text(m == 0 ? 'No gap' : '$m Minutes'),
                ),
              )
              .toList(),
        ),
        SizedBox(height: 6.h),
        Text(
          'This buffer will be added after the session for documentation.',
          style: appTheme.descriptionSmallTextStyle.copyWith(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 11.sp,
            height: 16 / 11,
            color: appTheme.placeholderColor,
          ),
        ),
      ],
    );
  }
}
