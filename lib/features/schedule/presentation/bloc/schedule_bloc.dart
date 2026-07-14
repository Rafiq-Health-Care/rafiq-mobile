import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/schedule/domain/entities/schedule_stats.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/domain/params/week_range_params.dart';
import 'package:rafiq/features/schedule/domain/usecases/get_weekly_schedule.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final GetWeeklySchedule getWeeklySchedule;

  ScheduleBloc({required this.getWeeklySchedule}) : super(ScheduleState.initial()) {
    on<LoadWeekRequested>(_onLoadWeek);
    on<NextWeekRequested>(_onNextWeek);
    on<PreviousWeekRequested>(_onPreviousWeek);
    on<RefreshWeekRequested>(_onRefresh);
  }

  Future<void> _onLoadWeek(
    LoadWeekRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    final monday =
        event.anchorDate.subtract(Duration(days: event.anchorDate.weekday - 1));
    final start = DateTime(monday.year, monday.month, monday.day);
    final end = start.add(const Duration(days: 6, hours: 23, minutes: 59));

    emit(state.copyWith(status: ScheduleStatus.loading, weekStart: start, weekEnd: end));
    await _fetchAndEmit(start, end, emit);
  }

  Future<void> _onNextWeek(
    NextWeekRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    final newStart = state.weekStart.add(const Duration(days: 7));
    final newEnd = newStart.add(const Duration(days: 6, hours: 23, minutes: 59));
    emit(state.copyWith(status: ScheduleStatus.loading, weekStart: newStart, weekEnd: newEnd));
    await _fetchAndEmit(newStart, newEnd, emit);
  }

  Future<void> _onPreviousWeek(
    PreviousWeekRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    final newStart = state.weekStart.subtract(const Duration(days: 7));
    final newEnd = newStart.add(const Duration(days: 6, hours: 23, minutes: 59));
    emit(state.copyWith(status: ScheduleStatus.loading, weekStart: newStart, weekEnd: newEnd));
    await _fetchAndEmit(newStart, newEnd, emit);
  }

  Future<void> _onRefresh(
    RefreshWeekRequested event,
    Emitter<ScheduleState> emit,
  ) async {
    await _fetchAndEmit(state.weekStart, state.weekEnd, emit);
  }

  Future<void> _fetchAndEmit(
    DateTime start,
    DateTime end,
    Emitter<ScheduleState> emit,
  ) async {
    final result = await getWeeklySchedule(
      WeekRangeParams(startDate: start, endDate: end),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        status: ScheduleStatus.failure,
        errorMessage: failure.message,
      )),
      (slots) {
        final days = _groupByDay(start, slots);
        emit(state.copyWith(
          status: ScheduleStatus.success,
          days: days,
          stats: ScheduleStats.fromSlots(slots),
          errorMessage: null,
        ));
      },
    );
  }

  List<ScheduleDay> _groupByDay(DateTime weekStart, List<SlotEntity> slots) {
    return List.generate(7, (i) {
      final date = weekStart.add(Duration(days: i));
      final daySlots = slots.where((s) =>
          s.startTime.year == date.year &&
          s.startTime.month == date.month &&
          s.startTime.day == date.day).toList()
        ..sort((a, b) => a.startTime.compareTo(b.startTime));
      final isWeekend = date.weekday == DateTime.saturday ||
          date.weekday == DateTime.sunday;
      return ScheduleDay(date: date, slots: daySlots, isWeekend: isWeekend);
    });
  }
}
