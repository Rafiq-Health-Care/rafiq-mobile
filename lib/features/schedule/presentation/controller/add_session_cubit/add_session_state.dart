part of 'add_session_cubit.dart';

sealed class AddSessionState extends Equatable {
  const AddSessionState();

  @override
  List<Object?> get props => [];
}

final class AddSessionIdle extends AddSessionState {
  const AddSessionIdle();
}

final class AddSessionSubmitting extends AddSessionState {
  const AddSessionSubmitting();
}

final class AddSessionSuccess extends AddSessionState {
  const AddSessionSuccess();
}

final class AddSessionFailure extends AddSessionState {
  final String message;

  const AddSessionFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
