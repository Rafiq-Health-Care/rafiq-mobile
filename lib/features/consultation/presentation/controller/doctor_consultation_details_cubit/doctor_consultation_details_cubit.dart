import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/features/consultation/domain/entity/doctor_consultation_entity.dart';
import 'package:rafiq/features/consultation/domain/enum/consultation_status.dart';
import 'package:rafiq/features/consultation/domain/use_case/cancel_consultation_use_case.dart';
import 'package:rafiq/features/consultation/domain/use_case/get_doctor_consultation_details_use_case.dart';

part 'doctor_consultation_details_state.dart';

class DoctorConsultationDetailsCubit
    extends Cubit<DoctorConsultationDetailsState> {
  final GetDoctorConsultationDetailsUseCase getConsultationDetails;
  final CancelConsultationUseCase cancelConsultation;

  DoctorConsultationDetailsCubit({
    required this.getConsultationDetails,
    required this.cancelConsultation,
  }) : super(const DoctorConsultationDetailsInitial());

  Future<void> fetchConsultationDetails(String slotId) async {
    emit(const DoctorConsultationDetailsLoading());

    final result = await getConsultationDetails(
      GetDoctorConsultationDetailsParams(slotId: slotId),
    );

    result.fold(
      (failure) => emit(DoctorConsultationDetailsError(failure.message)),
      (consultation) => emit(DoctorConsultationDetailsLoaded(consultation)),
    );
  }

  Future<void> cancelSession({String? reason}) async {
    final current = state;
    if (current is! DoctorConsultationDetailsLoaded) return;

    emit(const DoctorConsultationCancelling());

    final result = await cancelConsultation(
      CancelConsultationParams(
        consultationId: current.consultation.consultationId,
        reason: reason,
      ),
    );

    result.fold(
      (failure) {
        emit(DoctorConsultationCancelError(failure.message));
        DoctorConsultationDetailsLoaded(current.consultation);
      },
      (consultation) => emit(
        DoctorConsultationDetailsLoaded(
          current.consultation.copyWith(status: ConsultationStatus.cancelled),
        ),
      ),
    );
  }
}
