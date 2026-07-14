import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rafiq/features/Consultation/domain/entity/payment_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/reserve_consultation_slot_params.dart';
import 'package:rafiq/features/Consultation/domain/use_case/reserve_consultation_slot_use_case.dart';

part 'booking_confirm_state.dart';

class ReserveConsultationSlotCubit extends Cubit<ReserveConsultationSlotState> {
  final ReserveConsultationSlotUseCase reserveConsultationSlotUseCase;
  ReserveConsultationSlotCubit({required this.reserveConsultationSlotUseCase})
    : super(ReserveConsultationSlotInitial());

  Future<void> reserveConsultationSlot(
    ReserveConsultationSlotParams params,
  ) async {
    emit(ReserveConsultationSlotLoading());
    final result = await reserveConsultationSlotUseCase(params);
    result.fold(
      (failure) =>
          emit(ReserveConsultationSlotFailure(errorMessage: failure.message)),
      (paymentEntity) =>
          emit(ReserveConsultationSlotSuccess(paymentEntity: paymentEntity)),
    );
  }
}
