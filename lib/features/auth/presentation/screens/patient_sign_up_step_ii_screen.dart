import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/enum/gender_enum.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/presentation/formatters/birth_date_input_formatter.dart';
import 'package:rafiq/features/auth/presentation/sections/media_auth_section.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';
import 'package:rafiq/features/auth/presentation/widgets/gender_selector.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/auth/presentation/widgets/horizontal_text_divider.dart';

class PatientSignUpStepIIScreen extends StatefulWidget {
  const PatientSignUpStepIIScreen({super.key});

  @override
  State<PatientSignUpStepIIScreen> createState() =>
      _PatientSignUpStepIIScreenState();
}

class _PatientSignUpStepIIScreenState extends State<PatientSignUpStepIIScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthDateController = TextEditingController();
  Gender _selectedGender = Gender.male;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      (AuthCubit.get(context).userSignUpBody! as PatientSignUpRequest)
        ..password = _passwordController.text.trim()
        ..birthDate = _birthDateController.text
        ..gender = _selectedGender.name;

      AuthCubit.get(context).patientSignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      appBar: AppBar(
        title: Text('New Account', style: appTheme.headingTextStyle),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: appTheme.deepDarkBlueColor,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        forceMaterialTransparency: true,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomLabeledPasswordField(
                label: 'Password',
                hint: 'Enter password',
                controller: _passwordController,
                validator: Validation.validatePassword,
              ),
              CustomLabeledPasswordField(
                label: 'Confirm Password',
                hint: 'Re-enter password',
                controller: _confirmPasswordController,
                validator: (v) => Validation.confirmPassword(
                  v,
                  _passwordController.text.trim(),
                ),
              ),
              CustomLabeledTextField(
                label: 'Birth Date',
                hint: 'YYYY-MM-DD',
                controller: _birthDateController,
                keyboardType: TextInputType.datetime,
                validator: Validation.validateBirthDate,
                inputFormatters: [BirthDateInputFormatter()],
              ),
              GenderSelector(
                initialGender: _selectedGender,
                onChanged: (gender) {
                  _selectedGender = gender;
                },
              ),
              SizedBox(height: 16),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is PatientSignUpSuccess) {
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
                            'Create Account',
                            style: appTheme.buttonLabelTextStyle,
                          ),
                  );
                },
              ),
              HorizontalTextDivider(),
              MediaAuthSection(),
              const SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
