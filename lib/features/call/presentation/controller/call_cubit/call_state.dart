part of 'call_cubit.dart';

sealed class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

final class CallInitial extends CallState {}

final class CallLoading extends CallState {}

final class CallSuccess extends CallState {
  final AgoraCallEvent event;
  final CallEntity callEntity;

  const CallSuccess({required this.event, required this.callEntity});
  
  CallSuccess copyWith({
    final AgoraCallEvent? event,
    final CallEntity? callEntity,
  }) {
    return CallSuccess(
      event: event ?? this.event,
      callEntity: callEntity ?? this.callEntity,
    );
  }

  @override
  List<Object> get props => [event, callEntity];
}

final class CallEnd extends CallState {}

final class CallFailure extends CallState {
  final String message;
  const CallFailure({required this.message});

  @override
  List<Object> get props => [message];
}
