abstract class IBackgroundService {
  Future<void> initialize();
  Future<void> scheduleNightlyTask();
}
