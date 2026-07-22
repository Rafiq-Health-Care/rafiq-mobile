import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/local_failure.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/core/errors/unknown_failure.dart';
import 'package:rafiq/features/chat_bot/data/data_source/audio_player_data_source.dart';
import 'package:rafiq/features/chat_bot/data/data_source/audio_recorder_data_source.dart';
import 'package:rafiq/features/chat_bot/data/data_source/chat_remote_data_source.dart';
import 'package:rafiq/features/chat_bot/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final AudioRecorderDataSource recorderDataSource;
  final AudioPlayerDataSource playerDataSource;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.recorderDataSource,
    required this.playerDataSource,
  });

  @override
  Future<Either<Failure, String>> sendTextMessage(String text) async {
    try {
      final reply = await remoteDataSource.sendTextMessage(text);
      return Right(reply);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> sendVoiceMessage(
    String audioFilePath,
  ) async {
    try {
      final replyAudioPath = await remoteDataSource.sendVoiceMessage(
        audioFilePath,
      );
      return Right(replyAudioPath);
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> startRecording() async {
    try {
      final granted = await recorderDataSource.hasPermission();
      if (!granted) {
        return Left(
          LocalFailure('Please allow microphone access to send a voice message'),
        );
      }
      await recorderDataSource.start();
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> stopRecording() async {
    try {
      final path = await recorderDataSource.stop();
      if (path == null) {
        return Left(LocalFailure('Recording failed, please try again'));
      }
      return Right(path);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> cancelRecording() async {
    try {
      await recorderDataSource.cancel();
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> playAudio(String filePath) async {
    try {
      await playerDataSource.play(filePath);
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> stopPlayback() async {
    try {
      await playerDataSource.stop();
      return Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Stream<void> get onPlaybackComplete => playerDataSource.onComplete;
}
