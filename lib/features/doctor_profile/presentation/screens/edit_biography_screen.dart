import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_labeled_text_field.dart';
import 'package:rafiq/features/doctor_profile/presentation/controller/doctor_profile_edit_cubit/doctor_profile_edit_cubit.dart';

class EditBiographyScreen extends StatefulWidget {
  final String currentBiography;
  const EditBiographyScreen({super.key, required this.currentBiography});

  @override
  State<EditBiographyScreen> createState() => _EditBiographyScreenState();
}

class _EditBiographyScreenState extends State<EditBiographyScreen> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.currentBiography,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Scaffold(
      backgroundColor: appTheme.surfaceColor,
      appBar: CustomAppBar(
        title: Text('Edit Biography', style: appTheme.headingTextStyle),
      ),
      body: BlocConsumer<DoctorProfileEditCubit, DoctorProfileEditState>(
        listener: (context, state) {
          if (state is DoctorProfileEditSuccess) {
            SnackBarMessage.showSuccessSnackBar(
              context: context,
              message: 'Biography updated successfully',
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomLabeledTextField(
                  label: 'Biography',
                  hint: 'Tell patients about yourself...',
                  controller: _controller,
                  height: 220.h,
                ),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  backgroundColor: appTheme.deepDarkBlueColor,
                  foregroundColor: Colors.white,
                  onPressed: isSubmitting
                      ? () {}
                      : () => DoctorProfileEditCubit.get(
                          context,
                        ).updateBiography(_controller.text.trim()),
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
          );
        },
      ),
    );
  }
}
