import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/utils/extensions/snack_bar_extension.dart';
import 'package:rafiq/features/schedule/presentation/controller/add_session_cubit/add_session_cubit.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/add_session_action_bar.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/add_session_header.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/section_title.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/session_blocked_switch.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/session_date_time_row.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/session_duration_field.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/session_gap_interval_field.dart';
import 'package:rafiq/features/schedule/presentation/widgets/add_session/session_reason_field.dart';

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({super.key});

  @override
  State<AddSessionScreen> createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _dateNotifier = ValueNotifier<DateTime>(DateTime.now());
  final _timeNotifier = ValueNotifier<TimeOfDay>(TimeOfDay.now());
  final _gapMinutesNotifier = ValueNotifier<int>(10);
  final _isBlockedNotifier = ValueNotifier<bool>(false);
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _dateNotifier.dispose();
    _timeNotifier.dispose();
    _gapMinutesNotifier.dispose();
    _isBlockedNotifier.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _onSave(BuildContext context) {
    final date = _dateNotifier.value;
    final time = _timeNotifier.value;
    final start = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    if (start.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pick a date and time in the future.')),
      );
      return;
    }
    context.read<AddSessionCubit>().submit(startTime: start);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return BlocListener<AddSessionCubit, AddSessionState>(
      listener: (context, state) {
        if (state is AddSessionSuccess) {
          context.showSuccessSnackBar(message: 'Session Added Successfully');
          Navigator.of(context).pop(true);
        } else if (state is AddSessionFailure) {
          context.showErrorSnackBar(message: state.message);
        }
      },
      child: Scaffold(
        backgroundColor: appTheme.pageBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddSessionHeader(
                        onBack: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(height: 28.h),
                      const SectionTitle(
                        title: 'Schedule Details',
                        icon: Icons.event_note,
                      ),
                      SizedBox(height: 16.h),
                      SessionDateTimeRow(
                        dateNotifier: _dateNotifier,
                        timeNotifier: _timeNotifier,
                      ),
                      SizedBox(height: 20.h),
                      const SessionDurationField(),
                      SizedBox(height: 20.h),
                      SessionGapIntervalField(
                        gapMinutesNotifier: _gapMinutesNotifier,
                      ),
                      SizedBox(height: 20.h),
                      SessionBlockedSwitch(
                        isBlockedNotifier: _isBlockedNotifier,
                      ),
                      SizedBox(height: 20.h),
                      SessionReasonField(
                        isBlockedNotifier: _isBlockedNotifier,
                        controller: _reasonController,
                      ),
                    ],
                  ),
                ),
              ),
              AddSessionActionBar(
                onSave: () => _onSave(context),
                onCancel: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
