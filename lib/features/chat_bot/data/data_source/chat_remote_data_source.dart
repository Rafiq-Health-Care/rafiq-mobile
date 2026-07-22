import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rafiq/features/chat_bot/data/constants/chat_api_constants.dart';

abstract class ChatRemoteDataSource {
  Future<String> sendTextMessage(String text);

  Future<String> sendVoiceMessage(String audioFilePath);
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl({this.baseUrl = ChatApiConstants.baseUrl, Dio? dio})
    : _dio = dio ?? Dio() {
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 90,
        ),
      );
    }
  }

  final String baseUrl;
  final Dio _dio;

  @override
  Future<String> sendTextMessage(String text) async {
    final response = await _dio.post(
      '$baseUrl${ChatApiConstants.textChat}',
      data: {'text': text},
      options: Options(
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        responseType: ResponseType.json,
      ),
    );
    return response.data.toString();
  }

  @override
  Future<String> sendVoiceMessage(String audioFilePath) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(
        audioFilePath,
        filename: p.basename(audioFilePath),
        contentType: DioMediaType.parse("audio/mpeg"),
      ),
    });

    final response = await _dio.post(
      '$baseUrl${ChatApiConstants.voiceChat}',
      data: formData,
      options: Options(
        headers: {'accept': 'application/json'},
        responseType: ResponseType.bytes,
      ),
    );

    final tempDir = await getTemporaryDirectory();
    final savePath = p.join(
      tempDir.path,
      'chat_reply_${DateTime.now().millisecondsSinceEpoch}.mp3',
    );
    final file = File(savePath);
    await file.writeAsBytes(response.data as List<int>, flush: true);
    return savePath;
  }
}
