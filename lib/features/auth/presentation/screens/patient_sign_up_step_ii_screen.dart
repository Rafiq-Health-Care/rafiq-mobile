import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/enum/gender_enum.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/features/auth/data/service/validation.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/presentation/widgets/gender_selector.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class PatientSignUpStepIIScreen extends StatefulWidget {
  const PatientSignUpStepIIScreen({super.key});

  @override
  State<PatientSignUpStepIIScreen> createState() =>
      _PatientSignUpStepIIScreenState();
}

class _PatientSignUpStepIIScreenState extends State<PatientSignUpStepIIScreen> {
  final _formKey = GlobalKey<FormState>();

  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  Gender _selectedGender = Gender.male;

  @override
  void dispose() {
    _phoneController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      (AuthCubit.get(context).userSignUpBody! as PatientSignUpRequest)
        ..phone = _phoneController.text.trim()
        ..age = int.parse(_ageController.text)
        ..gender = _selectedGender.name;

      AuthCubit.get(context).patientSignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      appBar: AppBar(title: const Text('Patient Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
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

              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.of(context).pushNamed(
                      RouterStrings.otp,
                      arguments: AuthCubit.get(context).userSignUpBody!.email,
                    );
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
                        : Text('Sign Up', style: appTheme.buttonLabelTextStyle),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
