import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/core/widgets/custom_outlined_button.dart';
import 'package:rafiq/features/schedule/presentation/controller/add_session_cubit/add_session_cubit.dart';

class AddSessionActionBar extends StatelessWidget {
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const AddSessionActionBar({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: appTheme.pageBackgroundColor,
        border: Border(top: BorderSide(color: appTheme.borderColor)),
      ),
      child: SafeArea(
        top: false,
        child: BlocBuilder<AddSessionCubit, AddSessionState>(
          builder: (context, state) {
            final isSubmitting = state is AddSessionSubmitting;
            return Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: appTheme.deepDarkBlueColor,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: isSubmitting ? null : onSave,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        child: Center(
                          child: isSubmitting
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Save Changes',
                                  style: appTheme.buttonLabelTextStyle
                                      .copyWith(
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16.sp,
                                      ),
                                ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  width: double.infinity,
                  child: CustomOutlinedButton(
                    onPressed: isSubmitting ? () {} : onCancel,
                    foregroundColor: appTheme.secondaryTextColor,
                    borderSideColor: appTheme.borderColor,
                    borderRadius: 12,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
