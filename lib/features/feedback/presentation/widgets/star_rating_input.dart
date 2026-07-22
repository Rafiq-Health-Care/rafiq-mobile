import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';

class StarRatingInput extends StatelessWidget {
  final ValueNotifier<double> ratingNotifier;

  const StarRatingInput({super.key, required this.ratingNotifier});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return RatingBar.builder(
      initialRating: ratingNotifier.value,
      minRating: 0,
      itemCount: 5,
      allowHalfRating: true,
      glow: false,
      itemSize: 30.sp,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
      itemBuilder: (context, _) =>
          Icon(Icons.star_rounded, color: appTheme.starColor),
      unratedColor: appTheme.cardBorderColor,
      onRatingUpdate: (rating) => ratingNotifier.value = rating,
    );
  }
}
