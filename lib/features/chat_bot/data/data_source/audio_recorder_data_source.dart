import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

abstract class AudioRecorderDataSource {
  Future<void> start();
  Future<String?> stop();
  Future<void> cancel();
  Future<bool> hasPermission();
}

class AudioRecorderDataSourceImpl implements AudioRecorderDataSource {
  AudioRecorderDataSourceImpl({AudioRecorder? recorder})
    : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;

  @override
  Future<bool> hasPermission() => _recorder.hasPermission();

  @override
  Future<void> start() async {
    final tempDir = await getTemporaryDirectory();
    final path = p.join(
      tempDir.path,
      'chat_recording_${DateTime.now().millisecondsSinceEpoch}.m4a',
    );
    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        numChannels: 1,
        sampleRate: 44100,
      ),
      path: path,
    );
  }

  @override
  Future<String?> stop() async {
  final m4aPath = await _recorder.stop();
  if (m4aPath == null) return null;

  final mp3Path = m4aPath.replaceAll('.m4a', '.mp3');
  final session = await FFmpegKit.execute(
    '-i "$m4aPath" -codec:a libmp3lame -qscale:a 2 "$mp3Path"',
  );
  final returnCode = await session.getReturnCode();
  return returnCode?.isValueSuccess() == true ? mp3Path : null;
}

  @override
  Future<void> cancel() => _recorder.cancel();
}
