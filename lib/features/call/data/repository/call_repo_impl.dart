import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/call_failure.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/core/errors/unknown_failure.dart';
import 'package:rafiq/features/call/data/data_source/agora_data_source.dart';
import 'package:rafiq/features/call/data/data_source/remote_data_source.dart';
import 'package:rafiq/features/call/domain/event/agora_call_event.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';

class CallRepositoryImpl implements CallRepository {
  final AgoraDataSource agoraDataSource;
  final CallRemoteDataSource remoteDataSource;

  CallRepositoryImpl({
    required this.agoraDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, void>> startPreview() async {
    try {
      await agoraDataSource.initEngine();
      await agoraDataSource.startPreview();
      return Right(null);
    } on AgoraRtcException catch (e) {
      return Left(
        CallFailure("Error on Agora Service with start preview ${e.message}"),
      );
    } catch (e) {
      return Left(UnknownFailure("Unknown failure happen ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, String>> joinCall({
    required String consultationId,
    required int uid,
  }) async {
    try {
      final agoraModel = await remoteDataSource.joinCall(
        consultationId: consultationId,
      );

      await agoraDataSource.joinChannel(
        token: agoraModel.token,
        channelId: agoraModel.channelName,
        uid: uid,
      );
      return Right(agoraModel.channelName);
    } on AgoraRtcException catch (e) {
      return Left(
        CallFailure("Error on Agora Service with join call ${e.message}"),
      );
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure("Unknown failure happen ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> leaveCall({
    required String consultationId,
  }) async {
    try {
      await remoteDataSource.leaveCall(consultationId: consultationId);
      await agoraDataSource.leaveChannel();
      return Right(null);
    } on AgoraRtcException catch (e) {
      return Left(
        CallFailure("Error on Agora Service with leave call ${e.message}"),
      );
    } on ServerFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnknownFailure("Unknown failure happen ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> toggleAudio({required bool isAudioOn}) async {
    try {
      return right(await agoraDataSource.toggleAudio(isAudioOn: isAudioOn));
    } on AgoraRtcException catch (e) {
      return Left(
        CallFailure("Error on Agora Service with toggle audio ${e.message}"),
      );
    } catch (e) {
      return Left(UnknownFailure("Unknown failure happen ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, void>> toggleVideo({required bool isVideoOn}) async {
    try {
      return right(await agoraDataSource.toggleVideo(isVideoOn: isVideoOn));
    } on AgoraRtcException catch (e) {
      return Left(
        CallFailure("Error on Agora Service with toggle video ${e.message}"),
      );
    } catch (e) {
      return Left(UnknownFailure("Unknown failure happen ${e.toString()}"));
    }
  }

  @override
  Stream<AgoraCallEvent> get callEvents => agoraDataSource.callEvents;
}
