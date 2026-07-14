import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/Consultation/domain/entity/doctor_entity.dart';
import 'package:rafiq/features/Consultation/domain/entity/slot_entity.dart';
import 'package:rafiq/features/Consultation/presentation/screen/booking_confirm_screen.dart';

class SlotCard extends StatelessWidget {
  final DoctorEntity doctor;
  final SlotEntity slot;

  const SlotCard({super.key, required this.slot, required this.doctor});

  @override
  Widget build(BuildContext context) {
    // Formats: e.g., "Sunday, June 21" & "12:08 PM"
    final String dateStr = DateFormat('EEEE, MMMM d').format(slot.startTime);
    final String startTimeStr = DateFormat('hh:mm a').format(slot.startTime);
    final String endTimeStr = DateFormat('hh:mm a').format(slot.endTime);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left side Indicator/Icon block
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.appTheme.deepDarkBlueColor.withValues(
                    alpha: 0.08,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.access_time_filled_rounded,
                  color: context.appTheme.deepDarkBlueColor,
                  size: 28.sp,
                ),
              ),
              const SizedBox(width: 16),
              // Time details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dateStr,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$startTimeStr - $endTimeStr',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Action Button
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RouterStrings.bookingConfirm,
                    arguments: ConsultationArgs(doctor: doctor, slot: slot),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: context.appTheme.deepDarkBlueColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
                child: const Text(
                  'Book',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
