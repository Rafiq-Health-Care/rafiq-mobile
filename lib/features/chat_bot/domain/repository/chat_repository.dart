import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';

abstract class ChatRepository {
  /// Sends a plain text message to the assistant and returns its text reply.
  Future<Either<Failure, String>> sendTextMessage(String text);

  /// Uploads a recorded voice message and returns the local file path of the
  /// assistant's spoken reply (an mp3 saved on disk).
  Future<Either<Failure, String>> sendVoiceMessage(String audioFilePath);

  /// Starts capturing audio from the microphone.
  Future<Either<Failure, void>> startRecording();

  /// Stops the current recording and returns the local file path of the
  /// recorded audio.
  Future<Either<Failure, String>> stopRecording();

  /// Cancels the current recording without returning a usable file.
  Future<Either<Failure, void>> cancelRecording();

  /// Plays back an audio file (either the user's recording or a reply).
  Future<Either<Failure, void>> playAudio(String filePath);

  /// Stops any audio currently playing.
  Future<Either<Failure, void>> stopPlayback();

  /// Emits the file path whenever playback finishes on its own.
  Stream<void> get onPlaybackComplete;
}
