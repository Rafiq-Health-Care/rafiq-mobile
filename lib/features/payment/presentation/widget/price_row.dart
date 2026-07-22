import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/payment/domain/entity/price_item_entity.dart';

/// A single label/value row, e.g. "Total price" ... "$75.00".
class PriceRow extends StatelessWidget {
  final PriceItem item;

  const PriceRow({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item.label,
            style: TextStyle(
              color: context.appTheme.greyColor7,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            item.value,
            style: TextStyle(
              color: context.appTheme.deepDarkBlueColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// The larger, bold "Total Price" row shown at the bottom of the breakdown.
class TotalPriceRow extends StatelessWidget {
  final String value;

  const TotalPriceRow({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price',
            style: TextStyle(
              color: context.appTheme.deepDarkBlueColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: context.appTheme.deepDarkBlueColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
