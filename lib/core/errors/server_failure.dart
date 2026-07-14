import 'package:dio/dio.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/core/utils/extensions/number_range.dart';

class ServerFailure extends Failure {
  const ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout');

      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout');

      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout');

      case DioExceptionType.badCertificate:
        return ServerFailure('Bad Certificate');

      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response);

      case DioExceptionType.cancel:
        return ServerFailure('Request was canceled');

      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');

      case DioExceptionType.unknown:
        return ServerFailure('Unexpected Error, Please try again!');
    }
  }

  factory ServerFailure.fromResponse(Response? response) {
    final int? statusCode = response?.statusCode;
    final data = response?.data;

    if (statusCode != null && statusCode.isBetween(400, 499)) {
      return ServerFailure(data['message']);
    } else if (statusCode != null && statusCode.isBetween(500, 599)) {
      return ServerFailure('Internal Server error, Please try later');
    } else {
      return ServerFailure('Oops! There was an Error, Please try again');
    }
  }
}
