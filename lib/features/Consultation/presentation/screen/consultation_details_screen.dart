import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/core/utils/extensions/size_extension.dart';
import 'package:rafiq/core/widgets/custom_outlined_button.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/slot_entity.dart';
import 'package:rafiq/features/Consultation/presentation/controller/consultation_details_cubit/consultation_details_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/dialog/cancel_consultation_dialog.dart';
import 'package:rafiq/features/Consultation/presentation/widget/consultation_details.dart';
import 'package:rafiq/features/Consultation/presentation/widget/doctor_details_summary_card.dart';

class ConsultationDetailsScreen extends StatelessWidget {
  const ConsultationDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            start: 12.w,
            end: 12.w,
            top: kToolbarHeight + 10.h,
          ),
          child: BlocBuilder<ConsultationDetailsCubit, ConsultationDetailsState>(
            builder: (context, state) {
              if (state is ConsultationDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ConsultationDetailsLoaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomScreenHeader(
                      title: 'Consultation Details',
                      description:
                          'Booked Date: ${DateFormat('EEEE, MMMM d').format(state.consultationDetails.bookedAt)}',
                      total: state.consultationDetails.status.format(),
                      totalColor: Color(0XFF047857),
                    ),
                    SizedBox(height: 20.h),
                    DoctorDetailsSummaryCard(
                      doctor: DoctorEntity(
                        doctorId: state.consultationDetails.doctor.id,
                        firstName: state.consultationDetails.doctor.firstName,
                        lastName: state.consultationDetails.doctor.lastName,
                        specialization:
                            state.consultationDetails.doctor.specialization,
                        personalPhoto:
                            'https://i.postimg.cc/2ycZ7LrZ/ahmed.png',
                        nextAvailable: DateTime.now(),
                        price: state.consultationDetails.price,
                        rating: state.consultationDetails.rate.toDouble(),
                        yearsOfExperience: 5,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ConsultationDetailsSection(
                      slot: SlotEntity(
                        id: state.consultationDetails.slotId,
                        startTime: state.consultationDetails.startTime,
                        endTime: state.consultationDetails.startTime.add(
                          Duration(
                            minutes:
                                state.consultationDetails.durationInMinutes,
                          ),
                        ),
                      ),
                      fee: state.consultationDetails.price,
                    ),
                    SizedBox(height: 16.h),
                    ConsultationDetailsCard(
                      reason: state.consultationDetails.notes.isEmpty
                          ? 'No reason provided.'
                          : state.consultationDetails.notes,
                    ),
                    SizedBox(height: 32.h),
                    VideoConsultationButton(
                      onPressed: () {
                        context.navigateTo(
                          RouterStrings.consultationReady,
                          arguments: state.consultationDetails.consultationId,
                        );
                      },
                    ),
                    SizedBox(height: 12.h),
                    BookingActionRow(
                      onCancel: () {
                        showDialog(
                          context: context,
                          builder: (_) => CancelConsultationDialog(
                            doctorName:
                                'Dr.${state.consultationDetails.doctor.firstName} ${state.consultationDetails.doctor.lastName}',
                            consultationDate:
                                state.consultationDetails.startTime,
                            onCancel: () => context
                                .read<ConsultationDetailsCubit>()
                                .cancelConsultation(
                                  consultationId:
                                      state.consultationDetails.consultationId,
                                  reason:
                                      "<I want to cancel this consultation>",
                                ),
                          ),
                        );
                      },
                      onReschedule: () {},
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class ConsultationDetailsCard extends StatelessWidget {
  final String reason;
  const ConsultationDetailsCard({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xffE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2.r,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REASON FOR CONSULTATION',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
              letterSpacing: 0.6,
              color: Color(0xff64748B),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            width: context.width,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: const Color(0xffF8FAFC),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xffF1F5F9)),
            ),
            child: Text(
              reason,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
                height: 26 / 14,
                color: Color(0xff334155),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Instructions Sub-Section
          Text(
            'INSTRUCTIONS',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 11.sp,
              letterSpacing: 0.6,
              color: Color(0xff64748B),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Please ensure you are in a quiet room and have your recent vitals ready for discussion.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
              height: 20 / 13,
              color: Color(0xff475569),
            ),
          ),
        ],
      ),
    );
  }
}

class VideoConsultationButton extends StatelessWidget {
  final VoidCallback onPressed;

  const VideoConsultationButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      onPressed: onPressed,
      borderSideColor: const Color(0xffCBD5E1),
      foregroundColor: const Color(0xff0097B2),
      borderRadius: 12.r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_circle_outline,
            size: 20.sp,
            color: const Color(0xff0097B2),
          ),
          SizedBox(width: 8.w),
          Text(
            'Video Consultation Link',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              height: 1.4,
              color: Color(0xff0097B2),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingActionRow extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onReschedule;

  const BookingActionRow({
    super.key,
    required this.onCancel,
    required this.onReschedule,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 16.w,
      children: [
        // Cancel Appointment Button
        Expanded(
          flex:
              173, // Replicates structural ratio weights from Figma width attributes
          child: CustomOutlinedButton(
            onPressed: onCancel,
            foregroundColor: const Color(0xffDC2626),
            borderSideColor: const Color(0xffFEE2E2),
            borderRadius: 12.r,
            child: const Text(
              'Cancel Appointment',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ),
        // Reschedule Button
        Expanded(
          flex: 167,
          child: CustomOutlinedButton(
            onPressed: onReschedule,
            foregroundColor: const Color(0xff11325B),
            borderSideColor: const Color(0xff11325B).withValues(alpha: .22),
            borderRadius: 12.r,
            child: const Text(
              'Reschedule',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
