part of 'slot_cubit.dart';

sealed class SlotState extends Equatable {
  const SlotState();

  @override
  List<Object> get props => [];
}

final class SlotInitial extends SlotState {}

final class SlotLoading extends SlotState {}

final class SlotSuccess extends SlotState {
  final List<SlotEntity> slots;
  final PatientSeeDoctorSlotsParams params;
  final bool isLastPage;

  const SlotSuccess({
    required this.slots,
    required this.params,
    required this.isLastPage,
  });

  @override
  List<Object> get props => [slots, params, isLastPage];
}

final class SlotFailure extends SlotState {
  final String errorMessage;

  const SlotFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
