import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/di/di.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/navigation_extension.dart';
import 'package:rafiq/core/utils/responsive_utils.dart';
import 'package:rafiq/features/schedule/domain/entities/slot_entity.dart';
import 'package:rafiq/features/schedule/presentation/controller/schedule_bloc/schedule_bloc.dart';
import 'package:rafiq/features/schedule/presentation/controller/add_session_cubit/add_session_cubit.dart';
import 'package:rafiq/features/schedule/presentation/screens/add_session_screen.dart';
import 'package:rafiq/features/schedule/presentation/widgets/day_column.dart';
import 'package:rafiq/features/schedule/presentation/widgets/schedule_header.dart';
import 'package:rafiq/features/schedule/presentation/widgets/stats_bar.dart';
import 'package:rafiq/features/schedule/presentation/widgets/status_legend.dart';
import 'package:rafiq/features/schedule/presentation/widgets/week_date_selector.dart';

class WeeklySchedulePage extends StatefulWidget {
  const WeeklySchedulePage({super.key});

  @override
  State<WeeklySchedulePage> createState() => _WeeklySchedulePageState();
}

class _WeeklySchedulePageState extends State<WeeklySchedulePage> {
  final ScrollController _horizontalController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ScheduleBloc>().add(LoadWeekRequested(DateTime.now()));
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.appTheme.surfaceColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Decide how many day columns are visible at once based on the
            // available width. The rest of the week stays reachable via the
            // horizontally scrolling row below.
            final columnsVisible =
                ResponsiveUtils.columnsForWidth(constraints.maxWidth);
            final horizontalPadding = ResponsiveUtils.isMobile(constraints.maxWidth)
                ? 16.w
                : 32.w;
            final contentWidth = constraints.maxWidth - (horizontalPadding * 2);
            final columnWidth = (contentWidth / columnsVisible).clamp(220.0, 320.0);

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ScheduleBloc>().add(const RefreshWeekRequested());
                await context.read<ScheduleBloc>().stream.firstWhere(
                    (s) => s.status != ScheduleStatus.loading);
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: 20.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ScheduleHeader(onAddSession: () => _onAddSession(context)),
                    SizedBox(height: 20.h),
                    BlocBuilder<ScheduleBloc, ScheduleState>(
                      builder: (context, state) {
                        return WeekDateSelector(
                          weekStart: state.weekStart,
                          weekEnd: state.weekEnd,
                          onPrevious: () => context
                              .read<ScheduleBloc>()
                              .add(const PreviousWeekRequested()),
                          onNext: () => context
                              .read<ScheduleBloc>()
                              .add(const NextWeekRequested()),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    const StatusLegend(),
                    SizedBox(height: 20.h),
                    BlocBuilder<ScheduleBloc, ScheduleState>(
                      builder: (context, state) {
                        if (state.status == ScheduleStatus.loading &&
                            state.days.isEmpty) {
                          return SizedBox(
                            height: 400.h,
                            child: const Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (state.status == ScheduleStatus.failure) {
                          return _ErrorState(
                            message: state.errorMessage ?? 'Failed to load schedule.',
                            onRetry: () => context
                                .read<ScheduleBloc>()
                                .add(const RefreshWeekRequested()),
                          );
                        }
                        return SingleChildScrollView(
                          controller: _horizontalController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (final day in state.days)
                                DayColumn(
                                  day: day,
                                  width: columnWidth,
                                  onJoinCall: (slot) => _onJoinCall(context, slot),
                                  onSlotTap: (slot) => _onSlotTap(context, slot),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 24.h),
                    BlocBuilder<ScheduleBloc, ScheduleState>(
                      builder: (context, state) {
                        return StatsBar(
                          stats: state.stats,
                          onJoinNext: () {
                            if (state.stats.nextSession != null) {
                              _onJoinCall(context, state.stats.nextSession!);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onAddSession(BuildContext context) async {
    final scheduleBloc = context.read<ScheduleBloc>();
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (_) => getIt<AddSessionCubit>(),
          child: const AddSessionScreen(),
        ),
      ),
    );
    if (created == true) {
      scheduleBloc.add(const RefreshWeekRequested());
    }
  }

  void _onJoinCall(BuildContext context, SlotEntity slot) {
    context.navigateTo(RouterStrings.doctorConsultationDetails,arguments: slot.slotId);
  }

  void _onSlotTap(BuildContext context, SlotEntity slot) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tapped slot ${slot.slotId}')),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 40.sp, color: context.appTheme.accentRedColor),
            SizedBox(height: 12.h),
            Text(message, style: TextStyle(fontSize: 15.sp)),
            SizedBox(height: 12.h),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}