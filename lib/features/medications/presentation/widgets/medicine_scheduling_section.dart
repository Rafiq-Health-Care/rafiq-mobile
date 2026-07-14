import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/features/medications/presentation/widgets/MedicineSchedulingSection/custom_interval_selector.dart';
import 'package:rafiq/features/medications/presentation/widgets/MedicineSchedulingSection/dose_time_manager.dart';
import 'package:rafiq/features/medications/presentation/widgets/MedicineSchedulingSection/frequency_selector.dart';
import 'package:rafiq/features/medications/presentation/widgets/MedicineSchedulingSection/info_box.dart';
import 'package:rafiq/features/medications/presentation/enums/schedule_frequency.dart';
import 'package:rafiq/features/medications/presentation/widgets/MedicineSchedulingSection/section_header.dart';
import 'package:rafiq/features/medications/presentation/enums/week_days.dart';
import 'package:rafiq/features/medications/presentation/widgets/MedicineSchedulingSection/weekly_selector.dart';
import 'package:rafiq/features/medications/presentation/widgets/custom_date_picker.dart';
import 'package:rafiq/features/medications/presentation/widgets/icon_label.dart';

class MedicineSchedulingSection extends StatelessWidget {
  final ValueNotifier<List<TimeOfDay>> doseTimes;
  final ValueNotifier<ScheduleFrequency> frequencyNotifier;
  final ValueNotifier<List<WeekDays>> selectedWeeklyDays;
  final ValueNotifier<int> customInterval;
  final ValueNotifier<DateTime> startDateNotifier;
  final ValueNotifier<DateTime?> endDateNotifier;

  const MedicineSchedulingSection({
    super.key,
    required this.doseTimes,
    required this.frequencyNotifier,
    required this.selectedWeeklyDays,
    required this.customInterval,
    required this.startDateNotifier,
    required this.endDateNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconLabel(iconPath: ImageUrl().hourglass, title: 'Scheduling'),
        // --- Section 1: Dose Times ---
        const SchedulingSectionHeader(
          title: 'DOSE TIMES',
          subtitle: 'When should you take the medicine? (Add multiple times)',
        ),
        SizedBox(height: 12.h),
        DoseTimeManager(doseTimes: doseTimes),

        SizedBox(height: 24.h),

        // --- Section 2: Frequency ---
        const SchedulingSectionHeader(
          title: 'FREQUENCY',
          subtitle: 'How often should this schedule repeat?',
        ),
        SizedBox(height: 16.h),
        FrequencySelector(selectedFrequency: frequencyNotifier),

        SizedBox(height: 24.h),

        // --- Section 3: Dynamic Details ---
        ValueListenableBuilder<ScheduleFrequency>(
          valueListenable: frequencyNotifier,
          builder: (context, frequency, _) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: KeyedSubtree(
                key: ValueKey(frequency),
                child: _buildFrequencyDetails(frequency),
              ),
            );
          },
        ),

        SizedBox(height: 24.h),

        // --- Section 4: Duration ---
        const SchedulingSectionHeader(
          title: 'DURATION',
          subtitle: 'Set the start and end dates for your medication.',
        ),
        SizedBox(height: 16.h),
        Row(
          spacing: 16.w,
          children: [
            CustomDatePicker(
              label: 'Start Date',
              dateNotifier: startDateNotifier,
            ),
            CustomDatePicker(label: 'End Date', dateNotifier: endDateNotifier),
          ],
        ),
      ],
    );
  }

  Widget _buildFrequencyDetails(ScheduleFrequency freq) {
    switch (freq) {
      case ScheduleFrequency.once:
        return const SchedulingInfoBox(
          message:
              'The medication will be taken only once on the selected start date.',
          icon: Icons.event_available_rounded,
        );
      case ScheduleFrequency.daily:
        return const SchedulingInfoBox(
          message:
              'The medication schedule will repeat every day automatically.',
          icon: Icons.calendar_today_rounded,
        );
      case ScheduleFrequency.weekly:
        return WeeklySelector(selectedDays: selectedWeeklyDays);
      case ScheduleFrequency.custom:
        return CustomIntervalSelector(interval: customInterval);
    }
  }
}
