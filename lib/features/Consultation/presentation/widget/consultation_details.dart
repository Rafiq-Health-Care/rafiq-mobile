import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/features/Consultation/domain/entity/slot_entity.dart';
import 'package:rafiq/features/Consultation/presentation/widget/consultation_detail_item.dart';
class ConsultationDetailsSection extends StatelessWidget {
  final SlotEntity slot;
  final double fee;

  const ConsultationDetailsSection({
    required this.slot,
    required this.fee,
    super.key,  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('EEEE, MMM dd, yyyy').format(slot.startTime); // Tuesday, Oct 24, 2025
    final String formattedTime = '${DateFormat('hh:mm a').format(slot.startTime)} EST';   // 10:30 AM EST
    
    final int durationInMinutes = slot.endTime.difference(slot.startTime).inMinutes;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Section Header ---
          const Text(
            'CONSULTATION DETAILS',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 14,
              letterSpacing: 1.4,
              color: Color(0xFF94A3B8),
            ),
          ),
          const SizedBox(height: 14), 
          
          // --- Details List Container ---
          Column(
            children: [
              ConsultationDetailItem(
                icon: Icons.calendar_today_outlined,
                label: 'Date',
                value: formattedDate,
              ),
              ConsultationDetailItem(
                icon: Icons.access_time,
                label: 'Time',
                value: formattedTime,
              ),
              ConsultationDetailItem(
                icon: Icons.hourglass_empty_rounded,
                label: 'Duration',
                value: '$durationInMinutes min',
              ),
              ConsultationDetailItem(
                icon: Icons.account_balance_wallet_outlined,
                label: 'FEE',
                value: '\$${fee.toStringAsFixed(2)}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}