import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/experience_entity.dart';
import 'package:rafiq/features/doctor_profile/data/models/upsert_experience_request.dart';
import 'package:rafiq/features/doctor_profile/presentation/controller/doctor_profile_edit_cubit/doctor_profile_edit_cubit.dart';

/// Used for both adding a brand new experience entry and editing an
/// existing one — [existing] is null in "add" mode.
class UpsertExperienceScreen extends StatefulWidget {
  final ExperienceEntity? existing;
  const UpsertExperienceScreen({super.key, this.existing});

  bool get isEditMode => existing != null;

  @override
  State<UpsertExperienceScreen> createState() =>
      _UpsertExperienceScreenState();
}

class _UpsertExperienceScreenState extends State<UpsertExperienceScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _positionController =
      TextEditingController(text: widget.existing?.position ?? '');
  late final TextEditingController _hospitalController =
      TextEditingController(text: widget.existing?.hospital ?? '');
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.existing?.description ?? '');

  DateTime? _startDate;
  DateTime? _endDate;
  late bool _currentJob = widget.existing?.current ?? false;

  @override
  void initState() {
    super.initState();
    _startDate = widget.existing?.startDate;
    _endDate = widget.existing?.endDate;
  }

  @override
  void dispose() {
    _positionController.dispose();
    _hospitalController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickDate({required bool isStart}) async {
    final initial = (isStart ? _startDate : _endDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_startDate == null) {
      SnackBarMessage.showErrorSnackBar(
        context: context,
        message: 'Please select a start date',
      );
      return;
    }
    if (!_currentJob && _endDate == null) {
      SnackBarMessage.showErrorSnackBar(
        context: context,
        message: 'Please select an end date',
      );
      return;
    }

    final request = UpsertExperienceRequest(
      position: _positionController.text.trim(),
      hospitalName: _hospitalController.text.trim(),
      startDate: _startDate!,
      endDate: _currentJob ? null : _endDate,
      description: _descriptionController.text.trim(),
      currentJob: _currentJob,
    );

    DoctorProfileEditCubit.get(context).upsertExperience(
      request,
      experienceId: widget.existing?.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final dateFormat = DateFormat('yyyy-MM-dd');
    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      appBar: CustomAppBar(
        title: Text(
          widget.isEditMode ? 'Edit Experience' : 'Add Experience',
          style: appTheme.headingTextStyle,
        ),
      ),
      body: BlocConsumer<DoctorProfileEditCubit, DoctorProfileEditState>(
        listener: (context, state) {
          if (state is DoctorProfileEditSuccess) {
            SnackBarMessage.showSuccessSnackBar(
              context: context,
              message: widget.isEditMode
                  ? 'Experience updated successfully'
                  : 'Experience added successfully',
            );
            Navigator.of(context).pop(true);
          } else if (state is DoctorProfileEditFailure) {
            SnackBarMessage.showErrorSnackBar(
              context: context,
              message: state.message,
            );
          }
        },
        builder: (context, state) {
          final isSubmitting = state is DoctorProfileEditSubmitting;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 20,
                children: [
                  CustomLabeledTextField(
                    label: 'Position',
                    hint: 'e.g. Consultant Cardiologist',
                    controller: _positionController,
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Required'
                        : null,
                  ),
                  CustomLabeledTextField(
                    label: 'Hospital',
                    hint: 'e.g. Cairo University Hospital',
                    controller: _hospitalController,
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Required'
                        : null,
                  ),
                  _DateField(
                    label: 'Start Date',
                    value: _startDate,
                    formatted: _startDate != null
                        ? dateFormat.format(_startDate!)
                        : null,
                    onTap: () => _pickDate(isStart: true),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: _currentJob,
                        activeColor: appTheme.deepDarkBlueColor,
                        onChanged: (value) =>
                            setState(() => _currentJob = value ?? false),
                      ),
                      Text(
                        'I currently work here',
                        style: appTheme.textFieldLabelTextStyle,
                      ),
                    ],
                  ),
                  if (!_currentJob)
                    _DateField(
                      label: 'End Date',
                      value: _endDate,
                      formatted: _endDate != null
                          ? dateFormat.format(_endDate!)
                          : null,
                      onTap: () => _pickDate(isStart: false),
                    ),
                  CustomLabeledTextField(
                    label: 'Description',
                    hint: 'What did you do in this role?',
                    controller: _descriptionController,
                    height: 120.h,
                  ),
                  SizedBox(height: 4.h),
                  CustomElevatedButton(
                    backgroundColor: appTheme.deepDarkBlueColor,
                    foregroundColor: Colors.white,
                    onPressed: isSubmitting ? () {} : _submit,
                    child: isSubmitting
                        ? SizedBox(
                            height: 20.h,
                            width: 20.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            'Save',
                            style: appTheme.buttonLabelTextStyle.copyWith(
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? value;
  final String? formatted;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.value,
    required this.formatted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(label, style: appTheme.textFieldLabelTextStyle),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: InputDecorator(
            decoration: InputDecoration(
              border: appTheme.textFieldBorder,
              enabledBorder: appTheme.textFieldBorder,
              fillColor: appTheme.fieldFillColor,
              filled: true,
              suffixIcon: const Icon(Icons.calendar_today_outlined, size: 18),
            ),
            child: Text(
              formatted ?? 'Select a date',
              style: formatted != null
                  ? appTheme.textFieldTextStyle
                  : appTheme.textFieldHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
