part of 'doctor_consultation_details_cubit.dart';

abstract class DoctorConsultationDetailsState extends Equatable {
  const DoctorConsultationDetailsState();

  @override
  List<Object?> get props => [];
}

class DoctorConsultationDetailsInitial extends DoctorConsultationDetailsState {
  const DoctorConsultationDetailsInitial();
}

class DoctorConsultationDetailsLoading extends DoctorConsultationDetailsState {
  const DoctorConsultationDetailsLoading();
}

class DoctorConsultationDetailsLoaded extends DoctorConsultationDetailsState {
  final DoctorConsultationEntity consultation;
  const DoctorConsultationDetailsLoaded(this.consultation);

  @override
  List<Object?> get props => [consultation];
}

class DoctorConsultationDetailsError extends DoctorConsultationDetailsState {
  final String message;
  const DoctorConsultationDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class DoctorConsultationCancelling extends DoctorConsultationDetailsState {
  const DoctorConsultationCancelling();
}

class DoctorConsultationCancelError extends DoctorConsultationDetailsState {
  final String message;
  const DoctorConsultationCancelError(this.message);

  @override
  List<Object?> get props => [message];
}
