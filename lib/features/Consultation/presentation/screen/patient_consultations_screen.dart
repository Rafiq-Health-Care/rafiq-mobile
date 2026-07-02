import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rafiq/core/functions/snack_bar_message.dart';
import 'package:rafiq/core/utils/image_url.dart';
import 'package:rafiq/core/widgets/custom_app_bar.dart';
import 'package:rafiq/core/widgets/empty_state_widget.dart';
import 'package:rafiq/features/Consultation/domain/enum/consultation_status_enum.dart';
import 'package:rafiq/features/Consultation/domain/params/patient_consultation_params.dart';
import 'package:rafiq/features/Consultation/presentation/controller/consultation_cubit/consultation_cubit.dart';
import 'package:rafiq/features/Consultation/presentation/widget/consultation_card.dart';
import 'package:rafiq/features/Consultation/presentation/widget/consultation_shimmer.dart';
import 'package:rafiq/features/Consultation/presentation/widget/consultation_tab_bar.dart';

class PatientConsultationsScreen extends StatefulWidget {
  const PatientConsultationsScreen({super.key});

  @override
  State<PatientConsultationsScreen> createState() =>
      _PatientConsultationsScreenState();
}

class _PatientConsultationsScreenState
    extends State<PatientConsultationsScreen> {
  final selectedTabNotifier = ValueNotifier<ConsultationStatusEnum>(
    ConsultationStatusEnum.upcoming,
  );
  final List<ConsultationStatusEnum> stateTabs = [
    ConsultationStatusEnum.upcoming,
    ConsultationStatusEnum.completed,
    ConsultationStatusEnum.pending,
  ];

  @override
  void initState() {
    super.initState();
    context.read<ConsultationCubit>().getPatientConsultations(
      PatientConsultationParams(status: ConsultationStatusEnum.upcoming),
    );
  }

  @override
  void dispose() {
    selectedTabNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Text('My Consultations')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 23.h),
        child: Column(
          children: [
            ConsultationTabBar(
              selectedTabNotifier: selectedTabNotifier,
              stateTabs: stateTabs,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: BlocConsumer<ConsultationCubit, ConsultationState>(
                listener: (context, state) {
                  if (state is ConsultationFailure) {
                    SnackBarMessage.showErrorSnackBar(
                      message: state.errorMessage,
                      context: context,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ConsultationLoading) {
                    return ListView.separated(
                      itemCount: 5,
                      itemBuilder: (_, index) => const ConsultationShimmer(),
                      separatorBuilder: (_, _) => SizedBox(height: 16.h),
                    );
                  }
                  if (state is ConsultationSuccess) {
                    if (state.consultations.isEmpty) {
                      return EmptyStateWidget(
                        icon: SvgPicture.asset(
                          ImageUrl().file,
                          width: 120.w,
                          height: 150.h,
                        ),
                        title:
                            'No ${selectedTabNotifier.value.name} consultations',
                        description:
                            "You haven't booked any medical consultations yet.\nFind a specialist and schedule your first\nappointment today.",
                      );
                    }

                    return NotificationListener<ScrollNotification>(
                      onNotification: (scroll) {
                        if (scroll.metrics.pixels ==
                            scroll.metrics.maxScrollExtent) {
                          context
                              .read<ConsultationCubit>()
                              .loadMoreConsultations();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        itemCount: state.consultations.length,
                        itemBuilder: (context, index) {
                          return ConsultationCard(
                            consultation: state.consultations[index],
                          );
                        },
                        separatorBuilder: (_, _) => SizedBox(height: 16.h),
                      ),
                    );
                  }

                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
