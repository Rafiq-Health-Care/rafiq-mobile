import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/feedback/presentation/widgets/feedback_comment_field.dart';
import 'package:rafiq/features/feedback/presentation/widgets/star_rating_input.dart';

class FeedbackFormCard extends StatelessWidget {
  final ValueNotifier<double> ratingNotifier;
  final TextEditingController commentController;

  const FeedbackFormCard({
    super.key,
    required this.ratingNotifier,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: appTheme.surfaceColor,
        border: Border.all(
          color: appTheme.cardBorderColor.withValues(alpha: 0.3),
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: appTheme.dividerColor),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.reviews_outlined,
                  size: 20.sp,
                  color: appTheme.deepDarkBlueColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Feedback',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    fontWeight: FontWeight.w600,
                    fontSize: 24.sp,
                    height: 32 / 24,
                    letterSpacing: -0.24,
                    color: appTheme.inputTextColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
            child: Text(
              'How would you rate your experience with the provider today?',
              style: TextStyle(
                fontFamily: 'Manrope',
                fontSize: 13.sp,
                height: 24 / 13,
                color: appTheme.bodyMutedColor,
              ),
            ),
          ),
          StarRatingInput(ratingNotifier: ratingNotifier),
          SizedBox(height: 16.h),
          FeedbackCommentField(controller: commentController),
        ],
      ),
    );
  }
}
