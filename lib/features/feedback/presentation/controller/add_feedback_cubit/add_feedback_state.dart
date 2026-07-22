part of 'add_feedback_cubit.dart';

sealed class AddFeedbackState extends Equatable {
  const AddFeedbackState();

  @override
  List<Object?> get props => [];
}

final class AddFeedbackIdle extends AddFeedbackState {
  const AddFeedbackIdle();
}

final class AddFeedbackSubmitting extends AddFeedbackState {
  const AddFeedbackSubmitting();
}

final class AddFeedbackSuccess extends AddFeedbackState {
  const AddFeedbackSuccess();
}

final class AddFeedbackFailure extends AddFeedbackState {
  final String message;

  const AddFeedbackFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
