import 'package:dio/dio.dart';
import 'package:downloading_manager/core/errors/failure.dart';

class ServerFailure extends Failure {
  final DioExceptionType expType;
  ServerFailure({super.statusCode, this.expType = DioExceptionType.unknown});

  factory ServerFailure.catchError(dynamic exception) {
    if (exception is! DioException) return ServerFailure.unknownError();
    final type = exception.type;
    final statusCode = exception.response?.statusCode;
    switch (type) {
      case DioExceptionType.badResponse:
        return ServerFailure(statusCode: statusCode, expType: type);
      case DioExceptionType.badCertificate:
        return ServerFailure(statusCode: statusCode, expType: type);
      case DioExceptionType.receiveTimeout:
        return ServerFailure(statusCode: statusCode, expType: type);
      case DioExceptionType.sendTimeout:
        return ServerFailure(statusCode: statusCode, expType: type);
      case DioExceptionType.connectionTimeout:
        return ServerFailure(statusCode: statusCode, expType: type);
      case DioExceptionType.cancel:
        return ServerFailure(statusCode: statusCode, expType: type);
      case DioExceptionType.connectionError:
        return ServerFailure(statusCode: statusCode, expType: type);
      default:
        return ServerFailure.unknownError();
    }
  }

  factory ServerFailure.unknownError() {
    return ServerFailure(statusCode: 0, expType: DioExceptionType.unknown);
  }
}
