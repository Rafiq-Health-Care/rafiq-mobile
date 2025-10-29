import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/controllers/specialization_cubit/specialization_cubit.dart';
import 'package:rafiq/features/auth/data/enum/gender_enum.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/models/specialization_model.dart';
import 'package:rafiq/features/auth/data/service/validation.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/presentation/widgets/gender_selector.dart';
import 'package:rafiq/features/auth/presentation/widgets/specialization_selector.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class DoctorSignUpStepIIScreen extends StatefulWidget {
  const DoctorSignUpStepIIScreen({super.key});

  @override
  State<DoctorSignUpStepIIScreen> createState() =>
      _DoctorSignUpStepIIScreenState();
}

class _DoctorSignUpStepIIScreenState extends State<DoctorSignUpStepIIScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();

  Gender _selectedGender = Gender.male;
  int _selectedSpecializationIndex = 0;

  @override
  void initState() {
    super.initState();
    SpecializationCubit.get(context).getSpecializations();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _ageController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm(SpecializationModel specialization) {
    if (!_formKey.currentState!.validate()) return;

    final authCubit = AuthCubit.get(context);
    final doctorData = authCubit.userSignUpBody! as DoctorSignUpRequest;

    doctorData
      ..phone = _phoneController.text.trim()
      ..age = int.parse(_ageController.text)
      ..gender = _selectedGender.name
      ..specialization = specialization.id
      ..description = _descriptionController.text.trim();

    authCubit.doctorSignUp();
  }

  Widget _buildTextFields(AppTheme appTheme) {
    return Column(
      spacing: 18,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomLabeledTextField(
          label: 'Phone',
          hint: 'Enter phone number',
          controller: _phoneController,
          keyboardType: TextInputType.number,
          validator: Validation.validatePhone,
        ),
        CustomLabeledTextField(
          label: 'Age',
          hint: 'Enter your age',
          controller: _ageController,
          keyboardType: TextInputType.number,
          validator: Validation.validateAge,
        ),
        GenderSelector(
          initialGender: _selectedGender,
          onChanged: (gender) => _selectedGender = gender,
        ),
        CustomLabeledTextField(
          label: 'Description',
          hint: 'Short bio or details',
          controller: _descriptionController,
          validator: (v) => Validation.validateNonEmpty(v, 'Description'),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    AppTheme appTheme,
    List<SpecializationModel> specializations,
  ) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is DoctorSignUpSuccess) {
          Navigator.of(context).pushNamed(RouterStrings.otp);
        } else if (state is AuthFailure) {
          snackBarMessage(context, state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return CustomElevatedButton(
          onPressed: () {
            if (!isLoading) {
              _submitForm(specializations[_selectedSpecializationIndex]);
            }
          },
          backgroundColor: appTheme.deepDarkBlueColor,
          foregroundColor: appTheme.surfaceColor,
          child: isLoading
              ? const CircularProgressIndicator()
              : Text('Sign Up', style: appTheme.buttonLabelTextStyle),
        );
      },
    );
  }

  Widget _buildFormContent(
    BuildContext context,
    AppTheme appTheme,
    List<SpecializationModel> specializations,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 18,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFields(appTheme),
            SpecializationSelector(
              initialSpecializationIndex: _selectedSpecializationIndex,
              onChanged: (index) => _selectedSpecializationIndex = index,
              specializations: specializations,
            ),
            _buildSubmitButton(context, appTheme, specializations),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SpecializationCubit, SpecializationState>(
          builder: (context, state) {
            if (state is SpecializationLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SpecializationFailure) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is SpecializationSuccess) {
              return _buildFormContent(
                context,
                appTheme,
                state.specializations,
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
