import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/doctor_profile/presentation/controller/doctor_profile_edit_cubit/doctor_profile_edit_cubit.dart';

class EditPriceScreen extends StatefulWidget {
  final double currentPrice;
  const EditPriceScreen({super.key, required this.currentPrice});

  @override
  State<EditPriceScreen> createState() => _EditPriceScreenState();
}

class _EditPriceScreenState extends State<EditPriceScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller = TextEditingController(
    text: widget.currentPrice.toStringAsFixed(0),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final price = double.parse(_controller.text.trim());
      DoctorProfileEditCubit.get(context).setPrice(price);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      appBar: CustomAppBar(
        title: Text('Edit Consultation Fee', style: appTheme.headingTextStyle),
      ),
      body: BlocConsumer<DoctorProfileEditCubit, DoctorProfileEditState>(
        listener: (context, state) {
          if (state is DoctorProfileEditSuccess) {
            SnackBarMessage.showSuccessSnackBar(
              context: context,
              message: 'Price updated successfully',
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomLabeledTextField(
                    label: 'Consultation Fee',
                    hint: 'e.g. 300',
                    controller: _controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^\d*\.?\d{0,2}'),
                      ),
                    ],
                    prefixText: 'EGP  ',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a price';
                      }
                      final parsed = double.tryParse(value.trim());
                      if (parsed == null || parsed < 0) {
                        return 'Please enter a valid price';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24.h),
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
