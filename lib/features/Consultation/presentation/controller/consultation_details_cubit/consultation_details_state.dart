part of 'consultation_details_cubit.dart';

sealed class ConsultationDetailsState extends Equatable {
  const ConsultationDetailsState();

  @override
  List<Object> get props => [];
}

final class ConsultationDetailsInitial extends ConsultationDetailsState {}

final class ConsultationDetailsLoading extends ConsultationDetailsState {}

final class ConsultationDetailsLoaded extends ConsultationDetailsState {
  final ConsultationDetailsEntity consultationDetails;
  const ConsultationDetailsLoaded({required this.consultationDetails});
  @override
  List<Object> get props => [consultationDetails];
}

final class ConsultationDetailsError extends ConsultationDetailsState {
  final String message;
  const ConsultationDetailsError({required this.message});
  @override
  List<Object> get props => [message];
}
