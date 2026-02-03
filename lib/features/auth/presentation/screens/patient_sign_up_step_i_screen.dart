import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/models/patient_sign_up_request.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/auth/presentation/sections/media_auth_section.dart';
import 'package:rafiq/features/auth/presentation/widgets/horizontal_text_divider.dart';

class PatientSignUpStepIScreen extends StatefulWidget {
  const PatientSignUpStepIScreen({super.key});

  @override
  State<PatientSignUpStepIScreen> createState() =>
      _PatientSignUpStepIScreenState();
}

class _PatientSignUpStepIScreenState extends State<PatientSignUpStepIScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      AuthCubit.get(context).userSignUpBody = PatientSignUpRequest(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      Navigator.of(context).pushNamed(RouterStrings.signUpPatientStepII);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context).extension<AppTheme>()!;
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
              CustomLabeledTextField(
                label: 'First Name',
                hint: 'Enter your first name',
                controller: _firstNameController,
                validator: (v) => Validation.validateNonEmpty(v, 'First Name'),
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
              CustomLabeledTextField(
                label: 'Phone',
                hint: 'Enter phone number',
                controller: _phoneController,
                keyboardType: TextInputType.number,
                validator: Validation.validatePhone,
                prefixText: '+20 ',
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              SizedBox(height: 16),
              CustomElevatedButton(
                onPressed: _onSubmit,
                backgroundColor: appTheme.deepDarkBlueColor,
                foregroundColor: appTheme.surfaceColor,
                child: Text('Next', style: appTheme.buttonLabelTextStyle),
              ),
              HorizontalTextDivider(),
              MediaAuthSection(),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}
