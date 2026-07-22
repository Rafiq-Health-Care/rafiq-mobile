import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/core/utils/extensions/snack_bar_extension.dart';
import 'package:rafiq/features/feedback/presentation/controller/add_feedback_cubit/add_feedback_cubit.dart';
import 'package:rafiq/features/feedback/presentation/widgets/feedback_form_card.dart';
import 'package:rafiq/features/feedback/presentation/widgets/session_complete_header.dart';
import 'package:rafiq/features/feedback/presentation/widgets/view_summary_button.dart';

class FeedbackScreen extends StatefulWidget {
  final String consultationId;

  const FeedbackScreen({super.key, required this.consultationId});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _ratingNotifier = ValueNotifier<double>(0);
  final _commentController = TextEditingController();

  @override
  void dispose() {
    _ratingNotifier.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _onViewSummary(BuildContext context) {
    final rating = _ratingNotifier.value;
    if (rating <= 0) {
      return;
    }
    context.read<AddFeedbackCubit>().submit(
      rating: rating,
      comment: _commentController.text.trim(),
      consultationId: widget.consultationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return BlocListener<AddFeedbackCubit, AddFeedbackState>(
      listener: (context, state) {
        if (state is AddFeedbackSuccess) {
          context.navigateBack();
        } else if (state is AddFeedbackFailure) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.surfaceColor,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(12.w, 55.h, 12.w, 32.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SessionCompleteHeader(),
                SizedBox(height: 16.h),
                FeedbackFormCard(
                  ratingNotifier: _ratingNotifier,
                  commentController: _commentController,
                ),
                SizedBox(height: 32.h),
                SubmitButton(
                  onPressed: () => _onViewSummary(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
