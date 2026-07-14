import 'package:equatable/equatable.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_status.dart';

/// Pure domain entity — no JSON, no Flutter widget imports besides the
/// status enum. This is what the UI and use cases operate on.
class SlotEntity extends Equatable {
  final String slotId;
  final String? patientName;
  final DateTime startTime;
  final int durationInMinutes;
  final SlotStatus status;
  final String? consultationId;

  const SlotEntity({
    required this.slotId,
    required this.startTime,
    required this.durationInMinutes,
    required this.status,
    this.patientName,
    this.consultationId,
  });

  DateTime get endTime => startTime.add(Duration(minutes: durationInMinutes));

  @override
  List<Object?> get props => [
        slotId,
        patientName,
        startTime,
        durationInMinutes,
        status,
        consultationId,
      ];
}

/// A single calendar day, grouping all slots that fall on it. Built by the
/// repository/bloc from the flat list the API returns.
class ScheduleDay extends Equatable {
  final DateTime date;
  final List<SlotEntity> slots;
  final bool isWeekend;

  const ScheduleDay({
    required this.date,
    required this.slots,
    this.isWeekend = false,
  });

  @override
  List<Object?> get props => [date, slots, isWeekend];
}
