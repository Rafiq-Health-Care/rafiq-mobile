import 'package:rafiq/core/utils/extensions/formate_names.dart';

enum ScheduleFrequency {
  once,
  daily,
  weekly,
  custom;

  String get scheduleFrequencyStr {
    return name.format();
  }
}
