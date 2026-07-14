import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/take_action_or_cancel_button.dart';
import 'package:rafiq/features/groups/controllers/group_cubit/group_cubit.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';
import 'package:rafiq/features/medications/presentation/widgets/filter_section.dart';
import 'package:rafiq/features/medications/presentation/widgets/radio_tile.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late final ValueNotifier<MedicineStatusEnum?> _statusNotifier;
  late final ValueNotifier<MedicineTypeEnum?> _typeNotifier;
  late final ValueNotifier<String?> _groupNotifier;

  @override
  void initState() {
    super.initState();
    final state = MedicationCubit.of(context).state as MedicationLoaded;
    _statusNotifier = ValueNotifier(
      state.request.status ?? MedicineStatusEnum.all,
    );
    _typeNotifier = ValueNotifier(state.request.type ?? MedicineTypeEnum.all);
    _groupNotifier = ValueNotifier(state.request.groupId);
  }

  @override
  void dispose() {
    _statusNotifier.dispose();
    _typeNotifier.dispose();
    _groupNotifier.dispose();
    super.dispose();
  }

  void _clearAll() {
    MedicationCubit.of(
      context,
    ).filter(MedicineStatusEnum.all, MedicineTypeEnum.all, null);
    Navigator.of(context).pop();
  }

  void _applyFilters() {
    MedicationCubit.of(
      context,
    ).filter(_statusNotifier.value, _typeNotifier.value, _groupNotifier.value);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Filters',
          style: appTheme.headingTextStyle.copyWith(fontSize: 20.sp),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  ValueListenableBuilder<MedicineStatusEnum?>(
                    valueListenable: _statusNotifier,
                    builder: (context, selectedStatus, _) {
                      return FilterSection(
                        title: 'Status',
                        chips: MedicineStatusEnum.values.map((status) {
                          return RadioTile<MedicineStatusEnum?>(
                            title: status.name.format(),
                            value: status,
                            groupValue: selectedStatus,
                            onChanged: (val) => _statusNotifier.value = val,
                          );
                        }).toList(),
                      );
                    },
                  ),
                  BlocBuilder<GroupCubit, GroupState>(
                    builder: (context, state) {
                      if (state is GroupLoaded) {
                        return ValueListenableBuilder<String?>(
                          valueListenable: _groupNotifier,
                          builder: (context, selectedGroup, _) {
                            return FilterSection(
                              title: 'Group',
                              chips: [
                                RadioTile<String?>(
                                  title: 'All',
                                  value: null,
                                  groupValue: selectedGroup,
                                  onChanged: (val) =>
                                      _groupNotifier.value = val,
                                ),
                                ...state.allGroups.map((group) {
                                  return RadioTile<String?>(
                                    title: group.name.format(),
                                    value: group.id,
                                    groupValue: selectedGroup,
                                    onChanged: (val) =>
                                        _groupNotifier.value = val,
                                  );
                                }),
                              ],
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  ValueListenableBuilder<MedicineTypeEnum?>(
                    valueListenable: _typeNotifier,
                    builder: (context, selectedType, _) {
                      return FilterSection(
                        title: 'Type',
                        chips: MedicineTypeEnum.values.map((type) {
                          return RadioTile<MedicineTypeEnum?>(
                            title: type.name.format(),
                            value: type,
                            groupValue: selectedType,
                            onChanged: (val) => _typeNotifier.value = val,
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TakeActionOrCancelButton(
              action: _applyFilters,
              actionText: 'Apply Filters',
              cancelText: 'Clear All',
              cancelAction: _clearAll,
              cancelBackgroundColor: appTheme.softBlueColor,
              cancelForegroundColor: appTheme.deepDarkBlueColor,
              cancelTextStyle: appTheme.buttonLabelTextStyle.copyWith(
                color: appTheme.deepDarkBlueColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
