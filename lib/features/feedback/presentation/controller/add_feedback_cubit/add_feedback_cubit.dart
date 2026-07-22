import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rafiq/features/feedback/domain/params/add_feedback_params.dart';
import 'package:rafiq/features/feedback/domain/usecases/add_feedback_usecase.dart';

part 'add_feedback_state.dart';

class AddFeedbackCubit extends Cubit<AddFeedbackState> {
  final AddFeedbackUseCase _addFeedbackUseCase;

  AddFeedbackCubit(this._addFeedbackUseCase) : super(const AddFeedbackIdle());

  Future<void> submit({
    required double rating,
    required String comment,
    required String consultationId,
  }) async {
    emit(const AddFeedbackSubmitting());

    final result = await _addFeedbackUseCase(
      AddFeedbackParams(
        rating: rating,
        comment: comment,
        consultationId: consultationId,
      ),
    );

    result.fold(
      (failure) => emit(AddFeedbackFailure(message: failure.message)),
      (_) => emit(const AddFeedbackSuccess()),
    );
  }
}
