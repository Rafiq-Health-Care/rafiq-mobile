import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/feedback/domain/entities/feedback_entity.dart';
import 'package:rafiq/features/feedback/domain/usecases/get_doctor_feedback_usecase.dart';

part 'doctor_feedback_state.dart';

class DoctorFeedbackCubit extends Cubit<DoctorFeedbackState> {
  final GetDoctorFeedbackUseCase _getDoctorFeedbackUseCase;

  DoctorFeedbackCubit(this._getDoctorFeedbackUseCase)
    : super(const DoctorFeedbackLoading());

  Future<void> fetch(String doctorId) async {
    emit(const DoctorFeedbackLoading());

    final result = await _getDoctorFeedbackUseCase(doctorId);

    result.fold(
      (failure) => emit(DoctorFeedbackFailure(message: failure.message)),
      (feedback) => emit(DoctorFeedbackSuccess(feedback: feedback)),
    );
  }
}
