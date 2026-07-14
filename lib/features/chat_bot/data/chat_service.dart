import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/errors/server_failure.dart';
import 'package:rafiq/core/errors/unknown_failure.dart';

class ChatService {
  ChatService({this.baseUrl = 'http://192.168.0.104:8000', Dio? dio})
    : _dio = dio ?? Dio();

  final String baseUrl;
  final Dio _dio;

  Future<Either<Failure, String>> sendMessage(String text) async {
    try {
      final response = await _dio.post(
        '$baseUrl/chat/text',
        data: {'text': text},
        options: Options(
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json',
          },
          responseType: ResponseType.json,
        ),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
