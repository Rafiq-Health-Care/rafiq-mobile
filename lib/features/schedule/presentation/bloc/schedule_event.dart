part of 'schedule_bloc.dart';

abstract class ScheduleEvent extends Equatable {
  const ScheduleEvent();

  @override
  List<Object?> get props => [];
}

/// Loads the week that contains [anchorDate] (defaults to today on first
/// load). The bloc snaps this to the Monday of that week internally.
class LoadWeekRequested extends ScheduleEvent {
  final DateTime anchorDate;

  const LoadWeekRequested(this.anchorDate);

  @override
  List<Object?> get props => [anchorDate];
}

class NextWeekRequested extends ScheduleEvent {
  const NextWeekRequested();
}

class PreviousWeekRequested extends ScheduleEvent {
  const PreviousWeekRequested();
}

class RefreshWeekRequested extends ScheduleEvent {
  const RefreshWeekRequested();
}
