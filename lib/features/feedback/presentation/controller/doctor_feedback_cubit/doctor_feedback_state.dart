part of 'doctor_feedback_cubit.dart';

sealed class DoctorFeedbackState extends Equatable {
  const DoctorFeedbackState();

  @override
  List<Object?> get props => [];
}

final class DoctorFeedbackLoading extends DoctorFeedbackState {
  const DoctorFeedbackLoading();
}

final class DoctorFeedbackSuccess extends DoctorFeedbackState {
  final List<FeedbackEntity> feedback;

  const DoctorFeedbackSuccess({required this.feedback});

  @override
  List<Object?> get props => [feedback];
}

final class DoctorFeedbackFailure extends DoctorFeedbackState {
  final String message;

  const DoctorFeedbackFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
