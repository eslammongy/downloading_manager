import 'package:dio/dio.dart';
import 'package:downloading_manager/core/constant/dio_error_messages.dart';
import 'package:downloading_manager/core/errors/failure.dart';

class ServerFailure extends Failure {
  final DioExceptionType expType;
  ServerFailure({
    super.statusCode,
    this.expType = DioExceptionType.unknown,
    super.message,
  });

  factory ServerFailure.catchError(DioException exception) {
    final type = exception.type;
    final statusCode = exception.response?.statusCode;
    switch (type) {
      case DioExceptionType.badResponse:
        return ServerFailure(
          statusCode: statusCode,
          expType: type,
          message: DioErrorMessages.getBadResponseMsg(exception),
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          statusCode: statusCode,
          expType: type,
          message: DioErrorMessages.badCertificate,
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          statusCode: statusCode,
          expType: type,
          message: DioErrorMessages.receiveTimeout,
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          statusCode: statusCode,
          expType: type,
          message: DioErrorMessages.sendTimeout,
        );
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          statusCode: statusCode,
          expType: type,
          message: DioErrorMessages.connectionTimeout,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          statusCode: statusCode,
          expType: type,
          message: DioErrorMessages.requestCancelled,
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          statusCode: statusCode,
          expType: type,
          message: DioErrorMessages.getConnectionErrorMsg(exception),
        );
      default:
        return ServerFailure(
          expType: type,
          statusCode: statusCode,
          message: DioErrorMessages.getUnknownErrorMsg(exception),
        );
    }
  }

  /// Check if error is a network connectivity issue
  static bool isNetworkError(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout;
  }

  /// Check if error requires user authentication
  static bool isAuthenticationError(DioException error) {
    return error.response?.statusCode == 401;
  }

  /// Check if error is due to server issues
  static bool isServerError(DioException error) {
    final statusCode = error.response?.statusCode;
    return statusCode != null && statusCode >= 500;
  }

  /// Check if error is due to client issues
  static bool isClientError(DioException error) {
    final statusCode = error.response?.statusCode;
    return statusCode != null && statusCode >= 400 && statusCode < 500;
  }
}

// Extension method for easier usage
extension DioExceptionExtension on DioException {
  /// Check if this is a network error
  bool get isNetworkError => ServerFailure.isNetworkError(this);

  /// Check if this is an authentication error
  bool get isAuthError => ServerFailure.isAuthenticationError(this);

  /// Check if this is a server error
  bool get isServerError => ServerFailure.isServerError(this);

  /// Check if this is a client error
  bool get isClientError => ServerFailure.isClientError(this);
}
