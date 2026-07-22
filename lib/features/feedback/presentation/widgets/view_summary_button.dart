import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/feedback/presentation/controller/add_feedback_cubit/add_feedback_cubit.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return BlocBuilder<AddFeedbackCubit, AddFeedbackState>(
      builder: (context, state) {
        final isSubmitting = state is AddFeedbackSubmitting;
        return SizedBox(
          width: context.width,
          child: CustomElevatedButton(
            onPressed: isSubmitting ? () {} : onPressed,
            backgroundColor: appTheme.deepDarkBlueColor,
            foregroundColor: appTheme.surfaceColor,
            child: isSubmitting
                ? SizedBox(
                    width: 20.w,
                    height: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.2,
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  )
                : Text(
                    'Submit Feedback',
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      height: 32 / 16,
                      letterSpacing: -0.24,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
