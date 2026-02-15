import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_elevated_button.dart';
import 'package:rafiq/core/widgets/custom_outlined_button.dart';
import 'package:rafiq/features/lab_test/controller/lab_test_cubit/lab_test_cubit.dart';

class BottomActions extends StatelessWidget {
  final VoidCallback onSave;
  const BottomActions({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Row(
          spacing: 12,
          children: [
            Expanded(
              child: CustomOutlinedButton(
                onPressed: () => Navigator.pop(context),
                foregroundColor: appTheme.surfaceColor,
                borderSideColor: Colors.grey[300]!,
                child: Text(
                  'Cancel',
                  style: appTheme.buttonLabelTextStyle.copyWith(
                    color: appTheme.deepDarkBlueColor,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: BlocBuilder<LabTestCubit, LabTestState>(
                builder: (context, state) {
                  bool isLoading = state is LabTestLoading;
                  return CustomElevatedButton(
                    onPressed: () {
                      if (!isLoading) onSave();
                    },
                    backgroundColor: appTheme.deepDarkBlueColor,
                    foregroundColor: appTheme.surfaceColor,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            'Save & Continue',
                            style: appTheme.buttonLabelTextStyle,
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
