part of 'schedule_bloc.dart';

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  final ScheduleStatus status;
  final DateTime weekStart; // Monday 00:00 of the visible week
  final DateTime weekEnd; // Sunday 23:59 of the visible week
  final List<ScheduleDay> days;
  final ScheduleStats stats;
  final String? errorMessage;

  const ScheduleState({
    required this.status,
    required this.weekStart,
    required this.weekEnd,
    required this.days,
    required this.stats,
    this.errorMessage,
  });

  factory ScheduleState.initial() {
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final start = DateTime(monday.year, monday.month, monday.day);
    final end = start.add(const Duration(days: 6));
    return ScheduleState(
      status: ScheduleStatus.initial,
      weekStart: start,
      weekEnd: end,
      days: const [],
      stats: const ScheduleStats(weeklySlots: 0, completed: 0, pending: 0),
    );
  }

  ScheduleState copyWith({
    ScheduleStatus? status,
    DateTime? weekStart,
    DateTime? weekEnd,
    List<ScheduleDay>? days,
    ScheduleStats? stats,
    String? errorMessage,
  }) {
    return ScheduleState(
      status: status ?? this.status,
      weekStart: weekStart ?? this.weekStart,
      weekEnd: weekEnd ?? this.weekEnd,
      days: days ?? this.days,
      stats: stats ?? this.stats,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [status, weekStart, weekEnd, days, stats, errorMessage];
}
