import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/enum/gender_enum.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/features/auth/data/service/validation.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/presentation/widgets/gender_selector.dart';
import 'package:rafiq/features/landing/presentation/widgets/custom_elevated_button.dart';

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
  Gender _selectedGender = Gender.male;
  final _specializationController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _ageController.dispose();
    _specializationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      (AuthCubit.get(context).userSignUpBody! as DoctorSignUpRequest)
        ..phone = _phoneController.text.trim()
        ..age = int.parse(_ageController.text)
        ..gender = _selectedGender.name
        ..specialization = _specializationController.text.trim()
        ..description = _descriptionController.text.trim();

      AuthCubit.get(context).doctorSignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
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
                  onChanged: (gender) {
                    _selectedGender = gender;
                  },
                ),
                CustomLabeledTextField(
                  label: 'Specialization',
                  hint: 'e.g. Cardiologist',
                  controller: _specializationController,
                  validator: (v) =>
                      Validation.validateNonEmpty(v, 'Specialization'),
                ),
                CustomLabeledTextField(
                  label: 'Description',
                  hint: 'Short bio or details',
                  controller: _descriptionController,
                  validator: (v) =>
                      Validation.validateNonEmpty(v, 'Description'),
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.of(context).pushNamed(RouterStrings.otp);
                    }
                    if (state is AuthFailure) {
                      snackBarMessage(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      onPressed: () {
                        if (state is! AuthLoading) {
                          _onSubmit();
                        }
                      },
                      backgroundColor: appTheme.deepDarkBlueColor,
                      foregroundColor: appTheme.surfaceColor,
                      child: state is AuthLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Sign Up',
                              style: appTheme.buttonLabelTextStyle,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
