import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/router/router_strings.dart';
import 'package:rafiq/core/theme/app_theme.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_dropdown_button.dart';
import 'package:rafiq/features/auth/controllers/auth_cubit/auth_cubit.dart';
import 'package:rafiq/features/auth/controllers/specialization_cubit/specialization_cubit.dart';
import 'package:rafiq/features/auth/data/enum/gender_enum.dart';
import 'package:rafiq/features/auth/data/models/doctor_sign_up_request.dart';
import 'package:rafiq/core/services/validation.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/auth/presentation/formatters/birth_date_input_formatter.dart';
import 'package:rafiq/features/auth/presentation/sections/media_auth_section.dart';
import 'package:rafiq/features/auth/presentation/widgets/custom_labeled_password_field.dart';
import 'package:rafiq/features/auth/presentation/widgets/horizontal_text_divider.dart';
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

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _genderNotifier = ValueNotifier<Gender>(Gender.male);
  int _selectedSpecializationIndex = 0;

  @override
  void initState() {
    super.initState();
    SpecializationCubit.get(context).getSpecializations();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _birthDateController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm(String specialization) {
    if (!_formKey.currentState!.validate()) return;

    final authCubit = AuthCubit.get(context);
    final doctorData = authCubit.userSignUpBody! as DoctorSignUpRequest;

    doctorData
      ..password = _passwordController.text.trim()
      ..birthDate = _birthDateController.text
      ..gender = _genderNotifier.value.name
      ..specialization = specialization
      ..description = _descriptionController.text.trim();

    authCubit.doctorSignUp();
  }

  Widget _buildTextFields(AppTheme appTheme, List<String> specializations) {
    return Column(
      spacing: 18,
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
          validator: (v) =>
              Validation.confirmPassword(v, _passwordController.text.trim()),
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
        SpecializationSelector(
          initialSpecializationIndex: _selectedSpecializationIndex,
          onChanged: (index) => _selectedSpecializationIndex = index,
          specializations: specializations,
        ),
        CustomLabeledTextField(
          height: 90.h,
          label: 'Description',
          hint: 'Short bio or details',
          controller: _descriptionController,
          validator: (v) => Validation.validateNonEmpty(v, 'Description'),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(
    BuildContext context,
    AppTheme appTheme,
    List<String> specializations,
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
    List<String> specializations,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: 18,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFields(appTheme, specializations),
            _buildSubmitButton(context, appTheme, specializations),
            HorizontalTextDivider(),
            MediaAuthSection(),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('New Account', style: appTheme.headingTextStyle),
      ),
      body: BlocBuilder<SpecializationCubit, SpecializationState>(
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
            return _buildFormContent(context, appTheme, state.specializations);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
