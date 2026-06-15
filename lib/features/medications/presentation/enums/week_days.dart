enum WeekDays {
  saturday,
  sunday,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday;

  int get dayNumber {
    switch (this) {
      case WeekDays.saturday:
        return DateTime.saturday;
      case WeekDays.sunday:
        return DateTime.sunday;
      case WeekDays.monday:
        return DateTime.monday;
      case WeekDays.tuesday:
        return DateTime.tuesday;
      case WeekDays.wednesday:
        return DateTime.wednesday;
      case WeekDays.thursday:
        return DateTime.thursday;
      case WeekDays.friday:
        return DateTime.friday;
    }
  }

  String get shortName => name[0].toUpperCase();
}
