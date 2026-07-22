import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/schedule/domain/params/add_slot_params.dart';
import 'package:rafiq/features/schedule/domain/usecases/add_slot.dart';

part 'add_session_state.dart';

class AddSessionCubit extends Cubit<AddSessionState> {
  final AddSlot _addSlot;
  AddSessionCubit(this._addSlot) : super(const AddSessionIdle());

  Future<void> submit({required DateTime startTime}) async {
    emit(const AddSessionSubmitting());

    final result = await _addSlot(AddSlotParams(startTime: startTime));

    result.fold(
      (failure) => emit(AddSessionFailure(message: failure.message)),
      (_) => emit(const AddSessionSuccess()),
    );
  }
}
