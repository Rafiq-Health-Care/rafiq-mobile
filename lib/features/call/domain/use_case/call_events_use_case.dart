
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';

class CallEventsUseCase {
  final CallRepository repository;
  CallEventsUseCase(this.repository);

  Stream<AgoraCallEvent> get callEvents => repository.callEvents;
}
