part of 'consultation_details_cubit.dart';

abstract class ConsultationDetailsState extends Equatable {
  const ConsultationDetailsState();

  @override
  List<Object?> get props => [];
}

class ConsultationDetailsInitial extends ConsultationDetailsState {
  const ConsultationDetailsInitial();
}

class ConsultationDetailsLoading extends ConsultationDetailsState {
  const ConsultationDetailsLoading();
}

class ConsultationDetailsLoaded extends ConsultationDetailsState {
  final Consultation consultation;
  const ConsultationDetailsLoaded(this.consultation);

  @override
  List<Object?> get props => [consultation];
}

class ConsultationDetailsError extends ConsultationDetailsState {
  final String message;
  const ConsultationDetailsError(this.message);

  @override
  List<Object?> get props => [message];
}

class ConsultationCancelling extends ConsultationDetailsState {
  const ConsultationCancelling();
}

class ConsultationCancelError extends ConsultationDetailsState {
  final String message;
  const ConsultationCancelError(this.message);

  @override
  List<Object?> get props => [message];
}
