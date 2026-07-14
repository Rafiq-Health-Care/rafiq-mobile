import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/core/widgets/rafiq_primary_button.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/slot_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/reserve_consultation_slot_params.dart';
import 'package:rafiq/features/Consultation/presentation/controller/booking_confirm_cubit/booking_confirm_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/widget/consultation_details.dart';
import 'package:rafiq/features/Consultation/presentation/widget/doctor_details_summary_card.dart';
import 'package:rafiq/features/payment/payment_screen.dart';
import 'package:rafiq/features/payment/price_item.dart';

class ConsultationArgs {
  final DoctorEntity doctor;
  final SlotEntity slot;

  ConsultationArgs({required this.doctor, required this.slot});
}

class BookingConfirmScreen extends StatefulWidget {
  final DoctorEntity doctor;
  final SlotEntity slot;

  const BookingConfirmScreen({
    super.key,
    required this.doctor,
    required this.slot,
  });

  @override
  State<BookingConfirmScreen> createState() => _BookingConfirmScreenState();
}

class _BookingConfirmScreenState extends State<BookingConfirmScreen> {
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    notesController.dispose();
    super.dispose();
  }

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
          child: Column(
            spacing: 20.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomScreenHeader(
                title: 'Confirm Your Appointment',
                description:
                    'Please review the details below before finalizing your booking.',
              ),
              DoctorDetailsSummaryCard(doctor: widget.doctor),
              ConsultationDetailsSection(
                slot: widget.slot,
                fee: widget.doctor.price,
              ),
              CustomLabeledTextField(
                hint:
                    'e.g. Chest pain for 2 days, follow-up after blood tests...',
                controller: notesController,
                label: 'Reason for visit',
                isOptional: true,
                height: 120.h,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
              ),
              BlocConsumer<
                ReserveConsultationSlotCubit,
                ReserveConsultationSlotState
              >(
                listener: (context, state) async {
                  if (state is ReserveConsultationSlotSuccess) {
                    // Navigator.of(context).pushNamed(routeName)
                    // await makePayment(context, state.paymentEntity.paymentKey);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PaymentScreen(
                          paymentClientSecret: state.paymentEntity.paymentKey,
                          summary: ConsultationSummary(
                            totalPrice: widget.doctor.price,
                            tax: 0,
                            insurance: 0,
                            finalTotal: widget.doctor.price,
                          ),
                        ),
                      ),
                    );
                  } else if (state is ReserveConsultationSlotFailure) {
                    SnackBarMessage.showErrorSnackBar(
                      context: context,
                      message: state.errorMessage,
                    );
                  }
                },
                builder: (context, state) {
                  return RafiqPrimaryButton(
                    text: 'Confirm Booking',
                    icon: Icons.check_circle,
                    onPressed: () {
                      if (state is! ReserveConsultationSlotLoading) {
                        context
                            .read<ReserveConsultationSlotCubit>()
                            .reserveConsultationSlot(
                              ReserveConsultationSlotParams(
                                slotId: widget.slot.id,
                                notes: notesController.text.trim(),
                              ),
                            );
                      }
                    },
                    backgroundColor: context.appTheme.deepDarkBlueColor,
                    isLoading: state is ReserveConsultationSlotLoading,
                  );
                },
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
