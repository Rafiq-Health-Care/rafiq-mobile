import 'package:equatable/equatable.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_status.dart';

class ScheduleStats extends Equatable {
  final int weeklySlots;
  final int completed;
  final int pending;
  final SlotEntity? nextSession;

  const ScheduleStats({
    required this.weeklySlots,
    required this.completed,
    required this.pending,
    this.nextSession,
  });

  factory ScheduleStats.fromSlots(List<SlotEntity> slots) {
    final now = DateTime.now();
    SlotEntity? next;
    for (final slot in slots) {
      if (slot.status == SlotStatus.booked && slot.startTime.isAfter(now)) {
        if (next == null || slot.startTime.isBefore(next.startTime)) {
          next = slot;
        }
      }
    }
    return ScheduleStats(
      weeklySlots: slots.length,
      completed: slots.where((s) => s.status == SlotStatus.completed).length,
      pending: slots.where((s) => s.status == SlotStatus.pending).length,
      nextSession: next,
    );
  }

  @override
  List<Object?> get props => [weeklySlots, completed, pending, nextSession];
}
