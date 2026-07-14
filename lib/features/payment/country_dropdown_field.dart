import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/payment/country.dart';

class CountryDropdownField extends StatelessWidget {
  final String label;
  final ValueNotifier<Country> selectedCountry;

  const CountryDropdownField({
    super.key,
    required this.label,
    required this.selectedCountry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.appTheme.greyColor7,
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
        SizedBox(height: 10.h),
        ValueListenableBuilder<Country>(
          valueListenable: selectedCountry,
          builder: (context, value, _) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                border: Border.all(color: context.appTheme.greyColor6),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Country>(
                  value: value,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: context.appTheme.greyColor6,
                  ),
                  style: TextStyle(
                    color: context.appTheme.greyColor6,
                    fontSize: 16.sp,
                  ),
                  dropdownColor: context.appTheme.surfaceColor,
                  items: CountryData.countries
                      .map(
                        (country) => DropdownMenuItem(
                          value: country,
                          child: Text('${country.flagEmoji}  ${country.name}'),
                        ),
                      )
                      .toList(),
                  onChanged: (country) {
                    if (country != null) selectedCountry.value = country;
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
