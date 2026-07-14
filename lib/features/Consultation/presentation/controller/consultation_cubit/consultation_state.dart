part of 'consultation_cubit.dart';

sealed class ConsultationState extends Equatable {
  const ConsultationState();

  @override
  List<Object> get props => [];
}

final class ConsultationInitial extends ConsultationState {}

final class ConsultationLoading extends ConsultationState {}

final class ConsultationSuccess extends ConsultationState {
  final List<ConsultationEntity> consultations;
  final PatientConsultationParams patientConsultationParams;
  final bool isLastPage;

  const ConsultationSuccess({
    required this.consultations,
    required this.patientConsultationParams,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [
    consultations,
    patientConsultationParams,
    isLastPage,
  ];
}

final class ConsultationFailure extends ConsultationState {
  final String errorMessage;
  const ConsultationFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
