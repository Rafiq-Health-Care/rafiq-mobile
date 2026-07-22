import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rafiq/core/utils/extensions/formate_names.dart';
import 'package:rafiq/core/utils/extensions/get_app_theme.dart';
import 'package:rafiq/features/consultation/domain/enum/consultation_status.dart';
import 'package:rafiq/features/consultation/domain/params/patient_consultation_params.dart';
import 'package:rafiq/features/consultation/presentation/controller/consultation_cubit/consultation_cubit.dart';

class ConsultationTabBar extends StatelessWidget {
  final ValueNotifier<ConsultationStatus> selectedTabNotifier;
  final List<ConsultationStatus> stateTabs;

  const ConsultationTabBar({
    super.key,
    required this.selectedTabNotifier,
    required this.stateTabs,
  });

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    return Container(
      // Segmented Control Wrapper
      height: 48.h,
      padding: EdgeInsets.all(2.r),
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: ValueListenableBuilder(
        valueListenable: selectedTabNotifier,
        builder: (_, value, child) {
          return Row(
            children: List.generate(stateTabs.length, (index) {
              final selected = stateTabs[index] == value;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (stateTabs[index] == value) return;
                    selectedTabNotifier.value = stateTabs[index];
                    context.read<ConsultationCubit>().getPatientConsultations(
                      PatientConsultationParams(status: stateTabs[index]),
                    );
                  },
                  child: Container(
                    // Inner padding: 3px top/bottom, 10px left/right
                    padding: EdgeInsets.symmetric(
                      vertical: 3.h,
                      horizontal: 10.w,
                    ),
                    alignment: Alignment.center,
                    decoration: selected
                        ? BoxDecoration(
                            color: appTheme.deepDarkBlueColor,
                            borderRadius: BorderRadius.circular(32.r),
                            border: Border.all(
                              color: const Color(0x0A000000),
                              width: 0.5.r,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0x1F000000),
                                offset: Offset(0, 3.h),
                                blurRadius: 8.r,
                              ),
                              BoxShadow(
                                color: const Color(0x0A000000),
                                offset: Offset(0, 3.h),
                                blurRadius: 1.r,
                              ),
                            ],
                          )
                        : BoxDecoration(
                            color: const Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                    child: Text(
                      stateTabs[index].name.format(),
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: selected
                            ? const Color(0xffF2F2F2)
                            : const Color(0xff101010),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
