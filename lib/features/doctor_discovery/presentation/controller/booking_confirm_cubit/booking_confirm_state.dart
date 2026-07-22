part of 'booking_confirm_cubit.dart';

sealed class ReserveConsultationSlotState extends Equatable {
  const ReserveConsultationSlotState();

  @override
  List<Object> get props => [];
}

final class ReserveConsultationSlotInitial
    extends ReserveConsultationSlotState {}

final class ReserveConsultationSlotLoading
    extends ReserveConsultationSlotState {}

final class ReserveConsultationSlotSuccess
    extends ReserveConsultationSlotState {
  final PaymentEntity paymentEntity;
  const ReserveConsultationSlotSuccess({required this.paymentEntity});

  @override
  List<Object> get props => [paymentEntity];
}

final class ReserveConsultationSlotFailure
    extends ReserveConsultationSlotState {
  final String errorMessage;
  const ReserveConsultationSlotFailure({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
