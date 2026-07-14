import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/widgets/custom_screen_header.dart';
import 'package:rafiq/core/widgets/take_action_or_cancel_button.dart';
import 'package:rafiq/features/medications/controllers/medication_cubit/medication_cubit.dart';
import 'package:rafiq/features/medications/controllers/medication_details_cubit/medication_details_cubit.dart';
import 'package:rafiq/features/medications/controllers/search_medicine_name_cubit/search_medicine_name_cubit.dart';
import 'package:rafiq/features/medications/data/enums/medicine_status_enum.dart';
import 'package:rafiq/features/medications/data/enums/medicine_type_enum.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_model.dart';
import 'package:rafiq/features/medications/data/models/medicines_details_request.dart';
import 'package:rafiq/features/medications/data/models/update_medicine_request.dart';
import 'package:rafiq/features/medications/presentation/enums/schedule_frequency.dart';
import 'package:rafiq/features/medications/presentation/enums/week_days.dart';
import 'package:rafiq/features/medications/presentation/widgets/medicine_additional_info_section.dart';
import 'package:rafiq/features/medications/presentation/widgets/medicine_basic_info_section.dart';
import 'package:rafiq/features/medications/presentation/widgets/medicine_scheduling_section.dart';
import 'package:rafiq/features/medications/data/models/medicine_object_box_model.dart';

class MedicineUpsertScreen extends StatefulWidget {
  final MedicinesDetailsModel? medicineDetails;
  const MedicineUpsertScreen({super.key, this.medicineDetails});

  @override
  State<MedicineUpsertScreen> createState() => _MedicineUpsertScreenState();
}

class _MedicineUpsertScreenState extends State<MedicineUpsertScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _searchController;
  late final TextEditingController _dosageController;
  late final TextEditingController _instructionsController;
  late final ValueNotifier<MedicineTypeEnum> _medicineTypeNotifier;
  late final ValueNotifier<List<TimeOfDay>> _doseTimesNotifier;
  late final ValueNotifier<ScheduleFrequency> _frequencyNotifier;
  late final ValueNotifier<List<WeekDays>> _selectedWeeklyDays;
  late final ValueNotifier<int> _customInterval;
  late final ValueNotifier<DateTime> _startDateNotifier;
  late final ValueNotifier<DateTime?> _endDateNotifier;
  late final ValueNotifier<MedicineStatusEnum> _isActiveNotifier;
  late final ValueNotifier<bool> _enableRemindersNotifier;

  @override
  void initState() {
    super.initState();
    final medicine = widget.medicineDetails;
    SearchMedicineNameCubit.get(context).drugId = medicine?.id;
    _searchController = TextEditingController(text: medicine?.name);
    _dosageController = TextEditingController(text: medicine?.dosage);
    _instructionsController = TextEditingController(text: medicine?.notes);
    _medicineTypeNotifier = ValueNotifier(
      medicine?.type ?? MedicineTypeEnum.tablet,
    );

    // Initial dose time
    _startDateNotifier = ValueNotifier(medicine?.startDate ?? DateTime.now());
    _endDateNotifier = ValueNotifier(medicine?.endDate);
    // just from UI now and will see it with back end team
    _doseTimesNotifier = ValueNotifier<List<TimeOfDay>>([TimeOfDay.now()]);
    _frequencyNotifier = ValueNotifier(ScheduleFrequency.daily);
    _selectedWeeklyDays = ValueNotifier<List<WeekDays>>([WeekDays.monday]);
    _customInterval = ValueNotifier<int>(1);
    _isActiveNotifier = ValueNotifier(
      medicine?.status ?? MedicineStatusEnum.active,
    );
    _enableRemindersNotifier = ValueNotifier(
      medicine?.frequency.isNotEmpty ?? true,
    );
    //-------------------- This is just for UI till now ----------------- //
  }

  @override
  void dispose() {
    _searchController.dispose();
    _dosageController.dispose();
    _instructionsController.dispose();
    _medicineTypeNotifier.dispose();
    _doseTimesNotifier.dispose();
    _frequencyNotifier.dispose();
    _selectedWeeklyDays.dispose();
    _customInterval.dispose();
    _startDateNotifier.dispose();
    _endDateNotifier.dispose();
    _isActiveNotifier.dispose();
    _enableRemindersNotifier.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final drugId = SearchMedicineNameCubit.get(context).drugId;
    // final formattedTime = DateTimeService().formatTimeOfDay(_doseTimeNotifier.value,);

    if (widget.medicineDetails == null) {
      // Add
      final request = MedicinesDetailsRequest(
        medicineId: drugId!,
        dosage: _dosageController.text,
        frequency: 'ONCE',
        reminderFrequency: 'MONTHLY',
        startDate: _startDateNotifier.value,
        endDate: _endDateNotifier.value,
        notes: _instructionsController.text,
        type: _medicineTypeNotifier.value,
        customDays: [],
      );
      await MedicationCubit.of(context).addMedicine(request);
    } else {
      // Edit
      // Note: UpdateMedicineRequest requires name, not ID.
      final request = UpdateMedicineRequest(
        name: _searchController.text,
        dosage: _dosageController.text,
        notes: _instructionsController.text,
        frequency: 'ONCE',
        startDate: _startDateNotifier.value,
        endDate: _endDateNotifier.value ?? DateTime.now(),
        type: _medicineTypeNotifier.value,
        status: _isActiveNotifier.value,
        reminderFrequency: 'MONTHLY',
        customDays: [],
      );
      await context.read<MedicationDetailsCubit>().updateMedicineDetails(
        request,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final isEditing = widget.medicineDetails != null;

    return Scaffold(
      appBar: CustomAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<MedicationCubit, MedicationState>(
            listener: (_, state) async {
              if (state is MedicationAdded) {
                // Save locally too
                final medicine = MedicineObjectBoxModel(
                  id: state.newMedicine.id,
                  name: state.newMedicine.name,
                  dosage: state.newMedicine.dosage,
                  startDate: _startDateNotifier.value,
                  endDate: _endDateNotifier.value,
                  type: _medicineTypeNotifier.value.name,
                  status: _isActiveNotifier.value.name,
                  notes: _instructionsController.text,
                  doseTimesStrings: _doseTimesNotifier.value
                      .map((t) => "${t.hour}:${t.minute}")
                      .toList(),
                  frequency: _frequencyNotifier.value.name,
                  selectedWeeklyDaysInts: _selectedWeeklyDays.value
                      .map((d) => d.dayNumber)
                      .toList(),
                  customInterval: _customInterval.value,
                );
                await context
                    .read<MedicationCubit>()
                    .medicationRepository
                    .storeMedicineLocally(medicine);

                if (context.mounted) {
                  Navigator.pushReplacementNamed(
                    context,
                    RouterStrings.medicationDetails,
                    arguments: state.newMedicine.id,
                  );
                  SnackBarMessage.showSuccessSnackBar(
                    message:
                        'Medicine saved successfully locally and on server',
                    context: context,
                  );
                }
              } else if (state is MedicationError) {
                SnackBarMessage.showErrorSnackBar(
                  message: state.message,
                  context: context,
                );
              }
            },
          ),
          BlocListener<MedicationDetailsCubit, MedicationDetailsState>(
            listener: (context, state) async {
              if (state is MedicationDetailsLoaded) {
                // Update locally too
                final repository = context
                    .read<MedicationDetailsCubit>()
                    .medicationRepository;
                final localMedicines = await repository.readMedicinesLocally();
                int? existingObxId;
                localMedicines.fold((_) => null, (list) {
                  try {
                    existingObxId = list
                        .firstWhere((m) => m.id == state.medicationDetails.id)
                        .objectBoxID;
                  } catch (_) {
                    existingObxId = null;
                  }
                });

                final medicine = MedicineObjectBoxModel(
                  objectBoxID: existingObxId ?? 0,
                  id: state.medicationDetails.id,
                  name: state.medicationDetails.name,
                  dosage: state.medicationDetails.dosage,
                  startDate: state.medicationDetails.startDate,
                  endDate: state.medicationDetails.endDate,
                  type: state.medicationDetails.type?.name,
                  status: state.medicationDetails.status.name,
                  notes: state.medicationDetails.notes,
                  doseTimesStrings: _doseTimesNotifier.value
                      .map((t) => "${t.hour}:${t.minute}")
                      .toList(),
                  frequency: state.medicationDetails.frequency,
                  selectedWeeklyDaysInts: _selectedWeeklyDays.value
                      .map((d) => d.dayNumber)
                      .toList(),
                  customInterval: _customInterval.value,
                );

                await repository.updateMedicineLocally(medicine);

                if (context.mounted && isEditing) {
                  Navigator.of(context).pop();
                  SnackBarMessage.showSuccessSnackBar(
                    message:
                        'Medicine updated successfully locally and on server',
                    context: context,
                  );
                }
              } else if (state is MedicationDetailsError) {
                SnackBarMessage.showErrorSnackBar(
                  message: state.message,
                  context: context,
                );
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomScreenHeader(
                  title: isEditing ? 'Edit Medicine' : 'Add New Medicine',
                  description: isEditing
                      ? 'Update the details for ${widget.medicineDetails!.name}'
                      : 'Fill in the details below to add a new medication to your record.',
                ),
                const SizedBox(height: 24),
                MedicineBasicInfoSection(
                  searchController: _searchController,
                  dosageController: _dosageController,
                  medicineTypeNotifier: _medicineTypeNotifier,
                ),
                const SizedBox(height: 24),
                MedicineSchedulingSection(
                  doseTimes: _doseTimesNotifier,
                  frequencyNotifier: _frequencyNotifier,
                  selectedWeeklyDays: _selectedWeeklyDays,
                  customInterval: _customInterval,
                  startDateNotifier: _startDateNotifier,
                  endDateNotifier: _endDateNotifier,
                ),
                const SizedBox(height: 24),
                MedicineAdditionalInfoSection(
                  instructionsController: _instructionsController,
                  enableRemindersNotifier: _enableRemindersNotifier,
                  isActiveNotifier: _isActiveNotifier,
                ),
                const SizedBox(height: 32),
                TakeActionOrCancelButton(
                  action: _save,
                  actionText: 'Save & Continue',
                  cancelBackgroundColor: appTheme.surfaceColor,
                  cancelForegroundColor: appTheme.deepDarkBlueColor,
                  cancelTextStyle: appTheme.buttonLabelTextStyle.copyWith(
                    color: appTheme.deepDarkBlueColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
