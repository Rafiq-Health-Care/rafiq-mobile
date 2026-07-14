import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/core/utils/extensions/snack_bar_extension.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import '../../domain/entities/consultation.dart';
import '../consultation_details_cubit/consultation_details_cubit.dart';
import '../widgets/action_buttons.dart';
import '../widgets/cancel_reason_input.dart';
import '../widgets/cancellation_reason_card.dart';
import '../widgets/cancelled_alert_banner.dart';
import '../widgets/info_tile.dart';
import '../widgets/patient_header_card.dart';
import '../widgets/pre_consultation_notes_card.dart';

class DoctorConsultationDetailsScreen extends StatefulWidget {
  final String slotId;
  const DoctorConsultationDetailsScreen({super.key, required this.slotId});

  @override
  State<DoctorConsultationDetailsScreen> createState() =>
      _DoctorConsultationDetailsScreenState();
}

class _DoctorConsultationDetailsScreenState
    extends State<DoctorConsultationDetailsScreen> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      appBar: CustomAppBar(
        backgroundColor: appTheme.surfaceColor,
        centerTitle: true,
        title: Text(
          'Session Details',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            height: 1.4,
            color: Color(0xFF0097B2),
          ),
        ),
      ),

      body:
          BlocConsumer<
            DoctorConsultationDetailsCubit,
            ConsultationDetailsState
          >(
            buildWhen: (previous, current) {
              return current is ConsultationDetailsLoading ||
                  current is ConsultationDetailsLoaded ||
                  current is ConsultationDetailsError;
            },
            listener: (context, state) {
              if (state is ConsultationCancelError) {
                context.showErrorSnackBar(message: state.message);
              }
              if (state is ConsultationDetailsError) {
                context.showErrorSnackBar(message: state.message);
              }
            },
            builder: (context, state) {
              if (state is ConsultationDetailsError) {
                return _ErrorView(
                  message: state.message,
                  onRetry: () => context
                      .read<DoctorConsultationDetailsCubit>()
                      .fetchConsultationDetails(widget.slotId),
                );
              }

              final isCancelling = state is ConsultationCancelling;
              if (state is ConsultationDetailsLoaded) {
                return _ConsultationDetailsContent(
                  consultation: state.consultation,
                  reasonController: _reasonController,
                  isCancelling: isCancelling,
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  color: appTheme.deepDarkBlueColor,
                ),
              );
            },
          ),
    );
  }
}

class _ConsultationDetailsContent extends StatelessWidget {
  final Consultation consultation;
  final TextEditingController reasonController;
  final bool isCancelling;

  const _ConsultationDetailsContent({
    required this.consultation,
    required this.reasonController,
    required this.isCancelling,
  });

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('EEEE, MMM d, yyyy');
    final timeFmt = DateFormat('h:mm a');
    final dateLabel = dateFmt.format(consultation.startTime);
    final timeLabel =
        '${timeFmt.format(consultation.startTime)} - ${timeFmt.format(consultation.endTime)}';
    final shortIdLabel =
        '#${consultation.consultationId.substring(0, 8).toUpperCase()}';

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PatientHeaderCard(consultation: consultation),
          SizedBox(height: 20.h),

          if (consultation.isCancelled) ...[
            const CancelledAlertBanner(),
            SizedBox(height: 16.h),
          ],

          // Date / Time
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  icon: Icons.calendar_today,
                  label: 'DATE',
                  value: dateLabel,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: InfoTile(
                  icon: Icons.access_time,
                  label: 'TIME',
                  value: timeLabel,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Session ID / Consultation type
          Row(
            children: [
              Expanded(
                child: InfoTile(
                  icon: Icons.tag,
                  label: 'SESSION ID',
                  value: shortIdLabel,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: InfoTile(
                  icon: Icons.videocam_outlined,
                  label: 'BOOKED AT',
                  value: dateFmt.format(consultation.bookedAt),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          if (consultation.hasNotes) ...[
            PreConsultationNotesCard(notes: consultation.notes),
            SizedBox(height: 20.h),
          ],

          if (consultation.isCancelled &&
              consultation.hasCancellationReason) ...[
            CancellationReasonCard(consultation: consultation),
            SizedBox(height: 20.h),
          ],

          if (consultation.isCancellable) ...[
            CancelReasonInput(controller: reasonController),
            SizedBox(height: 24.h),
            PrimaryActionButton(
              label: 'Start Consultation',
              icon: Icons.videocam,
              loading: false,
              onPressed: () {
                context.navigateTo(
                  RouterStrings.callPreviewScreen,
                  arguments: consultation.consultationId,
                );
              },
            ),
            SizedBox(height: 12.h),
            DangerOutlineButton(
              label: 'Cancel Session',
              icon: Icons.close,
              loading: isCancelling,
              onPressed: () => _confirmCancel(context),
            ),
          ] else if (consultation.isCancelled) ...[
            PrimaryActionButton(
              label: 'Reschedule Session',
              icon: Icons.event_repeat,
              loading: false,
              onPressed: () {},
            ),
          ] else if (consultation.status == ConsultationStatus.live) ...[
            SizedBox(height: 24.h),
            PrimaryActionButton(
              label: 'Start Live Session',
              icon: Icons.videocam,
              loading: false,
              onPressed: () {
                context.navigateTo(
                  RouterStrings.callPreviewScreen,
                  arguments: consultation.consultationId,
                );
              },
            ),
          ],

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  void _confirmCancel(BuildContext context) {
    final cubit = context.read<DoctorConsultationDetailsCubit>();
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: const Text('Cancel this session?'),
        content: const Text(
          'The patient will be notified that this session was cancelled.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('Keep session'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              cubit.cancelSession(
                reason: reasonController.text.trim().isEmpty
                    ? null
                    : reasonController.text.trim(),
              );
            },
            child: const Text(
              'Cancel session',
              style: TextStyle(color: Color(0xFFF04040)),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 40.sp,
              color: const Color(0xFFF04040),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                height: 1.62,
                color: Color(0xFF334155),
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
