import 'package:flutter/material.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';

class DoctorSignUpStepIScreen extends StatefulWidget {
  const DoctorSignUpStepIScreen({super.key});

  @override
  State<DoctorSignUpStepIScreen> createState() =>
      _DoctorSignUpStepIScreenState();
}

class _DoctorSignUpStepIScreenState extends State<DoctorSignUpStepIScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      (AuthCubit.get(context).userSignUpBody! as DoctorSignUpRequest)
        ..firstName = _firstNameController.text.trim()
        ..lastName = _lastNameController.text.trim()
        ..email = _emailController.text.trim()
        ..password = _passwordController.text.trim();

      Navigator.of(context).pushNamed(RouterStrings.signUpDoctorStepII);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
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
                  label: 'First Name',
                  hint: 'Enter your first name',
                  controller: _firstNameController,
                  validator: (v) =>
                      Validation.validateNonEmpty(v, 'First Name'),
                ),
                CustomLabeledTextField(
                  label: 'Last Name',
                  hint: 'Enter your last name',
                  controller: _lastNameController,
                  validator: (v) => Validation.validateNonEmpty(v, 'Last Name'),
                ),
                CustomLabeledTextField(
                  label: 'Email',
                  hint: 'example@email.com',
                  controller: _emailController,
                  validator: Validation.validateEmail,
                ),
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

                CustomElevatedButton(
                  onPressed: _onSubmit,
                  backgroundColor: appTheme.deepDarkBlueColor,
                  foregroundColor: appTheme.surfaceColor,
                  child: Text('Next', style: appTheme.buttonLabelTextStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
