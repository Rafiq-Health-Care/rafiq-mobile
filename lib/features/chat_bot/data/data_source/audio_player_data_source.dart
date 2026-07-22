import 'package:audioplayers/audioplayers.dart';

abstract class AudioPlayerDataSource {
  Future<void> play(String filePath);
  Future<void> stop();
  Stream<void> get onComplete;
}

class AudioPlayerDataSourceImpl implements AudioPlayerDataSource {
  AudioPlayerDataSourceImpl({AudioPlayer? player})
    : _player = player ?? AudioPlayer();

  final AudioPlayer _player;

  @override
  Future<void> play(String filePath) async {
    await _player.stop();
    await _player.release();
    await _player.play(DeviceFileSource(filePath));
  }

  @override
  Future<void> stop() => _player.stop();

  @override
  Stream<void> get onComplete => _player.onPlayerComplete;
}
