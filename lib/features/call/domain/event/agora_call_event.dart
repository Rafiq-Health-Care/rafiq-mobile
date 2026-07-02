sealed class AgoraCallEvent {}

class LocalJoinedEvent extends AgoraCallEvent{}

class UserJoinedEvent extends AgoraCallEvent {
  final int uid;
  UserJoinedEvent(this.uid);
}

class UserLeftEvent extends AgoraCallEvent {
  final int uid;
  UserLeftEvent(this.uid);
}

class ConnectionStateChangedEvent extends AgoraCallEvent {
  final String state;
  ConnectionStateChangedEvent(this.state);
}
