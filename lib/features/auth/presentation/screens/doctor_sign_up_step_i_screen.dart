import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/features/auth/presentation/sections/media_auth_section.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/features/auth/presentation/widgets/horizontal_text_divider.dart';

class DoctorSignUpStepIScreen extends StatefulWidget {
  const DoctorSignUpStepIScreen({super.key});

  @override
  State<DoctorSignUpStepIScreen> createState() =>
      _DoctorSignUpStepIScreenState();
}

class _DoctorSignUpStepIScreenState extends State<DoctorSignUpStepIScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
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
      AuthCubit.get(context).userSignUpBody = DoctorSignUpRequest(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
      );

      Navigator.of(context).pushNamed(RouterStrings.signUpDoctorStepII);
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
            spacing: 18,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomLabeledTextField(
                label: 'First Name',
                hint: 'Enter your first name',
                controller: _firstNameController,
                validator: (v) => Validation.validateNonEmpty(v, 'First Name'),
                textInputAction: TextInputAction.next,
              ),
              CustomLabeledTextField(
                label: 'Last Name',
                hint: 'Enter your last name',
                controller: _lastNameController,
                validator: (v) => Validation.validateNonEmpty(v, 'Last Name'),
                textInputAction: TextInputAction.next,
              ),
              CustomLabeledTextField(
                label: 'Email',
                hint: 'example@email.com',
                controller: _emailController,
                validator: Validation.validateEmail,
                textInputAction: TextInputAction.next,
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
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _onSubmit(),
              ),
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
