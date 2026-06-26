import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/Consultation/domain/entity/consultation_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/patient_consultation_params.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_consultation_use_case.dart';

part 'consultation_state.dart';

class ConsultationCubit extends Cubit<ConsultationState> {
  final PatientConsultationUseCase patientConsultationsUseCase;
  ConsultationCubit(this.patientConsultationsUseCase)
    : super(ConsultationInitial());

  Future<void> getPatientConsultations(PatientConsultationParams params) async {
    emit(ConsultationLoading());
    final result = await patientConsultationsUseCase.call(params);
    result.fold(
      (failure) => emit(ConsultationFailure(errorMessage: failure.message)),
      (paginatedConsultationEntity) => emit(
        ConsultationSuccess(
          consultations: paginatedConsultationEntity.consultations,
          patientConsultationParams: params,
          isLastPage: paginatedConsultationEntity.isLastPage,
        ),
      ),
    );
  }

  Future<void> loadMoreConsultations() async {
    final currentState = state;
    if (currentState is! ConsultationSuccess || currentState.isLastPage) return;

    final page = currentState.patientConsultationParams.page + 1;
    final params = currentState.patientConsultationParams.copyWith(page: page);
    final result = await patientConsultationsUseCase.call(params);
    result.fold(
      (failure) => emit(ConsultationFailure(errorMessage: failure.message)),
      (paginatedConsultationEntity) => emit(
        ConsultationSuccess(
          consultations: [
            ...currentState.consultations,
            ...paginatedConsultationEntity.consultations,
          ],
          patientConsultationParams: params,
          isLastPage: paginatedConsultationEntity.isLastPage,
        ),
      ),
    );
  }
}
