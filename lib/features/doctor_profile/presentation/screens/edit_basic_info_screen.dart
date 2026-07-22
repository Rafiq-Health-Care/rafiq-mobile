import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/controllers/specialization_cubit/specialization_cubit.dart';
import 'package:rafiq/features/auth/presentation/widgets/specialization_selector.dart';
import 'package:rafiq/features/doctor_discovery/domain/entity/doctor_details_entity.dart';
import 'package:rafiq/features/doctor_profile/data/doctor_profile_constants.dart';
import 'package:rafiq/features/doctor_profile/data/models/update_basic_info_request.dart';
import 'package:rafiq/features/doctor_profile/presentation/controller/doctor_profile_edit_cubit/doctor_profile_edit_cubit.dart';
import 'package:rafiq/features/doctor_profile/presentation/widgets/chip_multi_select.dart';
import 'package:rafiq/features/doctor_profile/presentation/widgets/tag_chip_input.dart';

class EditBasicInfoScreen extends StatefulWidget {
  final DoctorDetailsEntity current;
  const EditBasicInfoScreen({super.key, required this.current});

  @override
  State<EditBasicInfoScreen> createState() => _EditBasicInfoScreenState();
}

class _EditBasicInfoScreenState extends State<EditBasicInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstNameController =
      TextEditingController(text: widget.current.firstName);
  late final TextEditingController _lastNameController =
      TextEditingController(text: widget.current.lastName);
  late final TextEditingController _descriptionController =
      TextEditingController(text: widget.current.description);
  late final TextEditingController _yearsController = TextEditingController(
    text: widget.current.yearsOfExperience.toString(),
  );

  String? _selectedSpecialization;
  List<String> _subSpecializations = [];
  List<String> _languages = [];

  @override
  void initState() {
    super.initState();
    SpecializationCubit.get(context).getSpecializations();
    _selectedSpecialization = widget.current.specialization;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _descriptionController.dispose();
    _yearsController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSpecialization == null) {
      SnackBarMessage.showErrorSnackBar(
        context: context,
        message: 'Please select a specialization',
      );
      return;
    }
    final request = UpdateBasicInfoRequest(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      specialization: _selectedSpecialization!,
      subSpecializations: _subSpecializations,
      languages: _languages,
      description: _descriptionController.text.trim(),
      yearsOfExperience: int.parse(_yearsController.text.trim()),
    );
    DoctorProfileEditCubit.get(context).updateBasicInfo(request);
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      appBar: CustomAppBar(
        title: Text('Edit Basic Info', style: appTheme.headingTextStyle),
      ),
      body: BlocConsumer<DoctorProfileEditCubit, DoctorProfileEditState>(
        listener: (context, state) {
          if (state is DoctorProfileEditSuccess) {
            SnackBarMessage.showSuccessSnackBar(
              context: context,
              message: 'Basic info updated successfully',
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
                    label: 'First Name',
                    hint: 'First name',
                    controller: _firstNameController,
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Required'
                        : null,
                  ),
                  CustomLabeledTextField(
                    label: 'Last Name',
                    hint: 'Last name',
                    controller: _lastNameController,
                    validator: (value) => (value == null || value.trim().isEmpty)
                        ? 'Required'
                        : null,
                  ),
                  BlocBuilder<SpecializationCubit, SpecializationState>(
                    builder: (context, specState) {
                      if (specState is SpecializationLoading ||
                          specState is SpecializationInitial) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (specState is SpecializationFailure) {
                        return Text(
                          'Could not load specializations: ${specState.message}',
                          style: TextStyle(color: appTheme.accentRedColor),
                        );
                      }
                      final specializations =
                          (specState as SpecializationSuccess)
                              .specializations;
                      var initialIndex = specializations.indexOf(
                        _selectedSpecialization ?? '',
                      );
                      if (initialIndex == -1) initialIndex = 0;
                      return SpecializationSelector(
                        specializations: specializations,
                        initialSpecializationIndex: initialIndex,
                        onChanged: (index) => setState(
                          () =>
                              _selectedSpecialization = specializations[index],
                        ),
                      );
                    },
                  ),
                  TagChipInput(
                    label: 'Sub-specializations',
                    hint: 'Type and press +',
                    tags: _subSpecializations,
                    onChanged: (tags) =>
                        setState(() => _subSpecializations = tags),
                  ),
                  ChipMultiSelect(
                    label: 'Languages',
                    options: kDoctorProfileLanguageOptions,
                    selected: _languages,
                    onChanged: (langs) => setState(() => _languages = langs),
                  ),
                  CustomLabeledTextField(
                    label: 'About',
                    hint: 'A short description shown on your profile',
                    controller: _descriptionController,
                    height: 120.h,
                  ),
                  CustomLabeledTextField(
                    label: 'Years of Experience',
                    hint: 'e.g. 5',
                    controller: _yearsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Required';
                      }
                      if (int.tryParse(value.trim()) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
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
