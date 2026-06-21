import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/Consultation/domain/entity/slot_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/patient_see_doctor_slots_params.dart';
import 'package:rafiq/features/Consultation/domain/use_case/patient_see_doctor_slots_use_case.dart';

part 'slot_state.dart';

class SlotCubit extends Cubit<SlotState> {
  final PatientSeeDoctorsSlotsUseCase patientSeeDoctorSlotsUseCase;
  SlotCubit({required this.patientSeeDoctorSlotsUseCase})
    : super(SlotInitial());

  Future<void> getSlots(PatientSeeDoctorSlotsParams params) async {
    emit(SlotLoading());
    final res = await patientSeeDoctorSlotsUseCase.call(params: params);
    res.fold(
      (l) => emit(SlotFailure(errorMessage: l.message)),
      (r) => emit(
        SlotSuccess(slots: r.slots, params: params, isLastPage: r.lastPage),
      ),
    );
  }

  Future<void> getMoreSlots() async {
    final currentState = state;
    if (currentState is! SlotSuccess || currentState.isLastPage) return;

    final res = await patientSeeDoctorSlotsUseCase.call(
      params: currentState.params.copyWith(page: currentState.params.page + 1),
    );

    res.fold(
      (l) => emit(SlotFailure(errorMessage: l.message)),
      (r) => emit(
        SlotSuccess(
          slots: currentState.slots + r.slots,
          params: currentState.params.copyWith(
            page: currentState.params.page + 1,
          ),
          isLastPage: r.lastPage,
        ),
      ),
    );
  }
}
