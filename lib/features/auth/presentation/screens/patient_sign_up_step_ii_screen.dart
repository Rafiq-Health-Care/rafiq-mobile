import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/enum/gender_enum.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/presentation/formatters/birth_date_input_formatter.dart';
import 'package:rafiq/features/auth/presentation/sections/media_auth_section.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/auth/presentation/widgets/horizontal_text_divider.dart';
import 'package:rafiq/core/widgets/custom_dropdown_button.dart';

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
  final _genderNotifier = ValueNotifier<Gender>(Gender.male);

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    _genderNotifier.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      (AuthCubit.get(context).userSignUpBody! as PatientSignUpRequest)
        ..password = _passwordController.text.trim()
        ..birthDate = _birthDateController.text
        ..gender = _genderNotifier.value.name;

      AuthCubit.get(context).patientSignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('New Account', style: appTheme.headingTextStyle),
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
                showValidationRules: true,
                controller: _passwordController,
                validator: Validation.validatePassword,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              CustomLabeledPasswordField(
                label: 'Confirm Password',
                hint: 'Re-enter password',
                controller: _confirmPasswordController,
                validator: (v) => Validation.confirmPassword(
                  v,
                  _passwordController.text.trim(),
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
              ),
              CustomLabeledTextField(
                label: 'Birth Date',
                hint: 'YYYY-MM-DD',
                controller: _birthDateController,
                keyboardType: TextInputType.datetime,
                validator: Validation.validateBirthDate,
                inputFormatters: [BirthDateInputFormatter()],
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
              ),
              CustomDropdownButton<Gender>(
                label: 'Gender',
                items: Gender.values.map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(
                      gender.name.format(),
                      style: appTheme.textFieldTextStyle,
                    ),
                  );
                }).toList(),
                valueNotifier: _genderNotifier,
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
