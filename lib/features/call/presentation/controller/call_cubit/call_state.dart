part of 'call_cubit.dart';

sealed class CallState extends Equatable {
  const CallState();

  @override
  List<Object> get props => [];
}

final class CallInitial extends CallState {}

final class CallLoading extends CallState {}

final class PreviewSuccess extends CallState {
  final CallParams callParams;
  const PreviewSuccess({required this.callParams});

  @override
  List<Object> get props => [callParams];
}

final class CallSuccess extends CallState {
  final AgoraCallEvent event;
  final CallParams callParams;
  final String channelId;

  const CallSuccess({required this.event, required this.callParams,required this.channelId});

  CallSuccess copyWith({
    final AgoraCallEvent? event,
    final CallParams? callParams,
  }) {
    return CallSuccess(
      event: event ?? this.event,
      callParams: callParams ?? this.callParams,
      channelId: channelId ,
    );
  }

  @override
  List<Object> get props => [event, callParams];
}

final class CallEnd extends CallState {}

final class CallFailure extends CallState {
  final String message;
  const CallFailure({required this.message});

  @override
  List<Object> get props => [message];
}
