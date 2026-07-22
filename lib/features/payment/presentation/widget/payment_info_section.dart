import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/payment/domain/entity/price_item_entity.dart';
import 'price_row.dart';

/// "Payment Info" section: title + a data-driven list of [PriceRow]s
/// followed by the bold [TotalPriceRow].
class PaymentInfoSection extends StatelessWidget {
  final List<PriceItem> items;
  final String totalLabel;

  const PaymentInfoSection({
    super.key,
    required this.items,
    required this.totalLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Payment Info',
          style: TextStyle(
            color: context.appTheme.deepDarkBlueColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        for (final item in items) PriceRow(item: item),
        Divider(color: context.appTheme.greyColor6, height: 24.h),
        TotalPriceRow(value: totalLabel),
      ],
    );
  }
}
