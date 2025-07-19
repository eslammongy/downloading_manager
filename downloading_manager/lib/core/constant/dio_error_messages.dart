import 'package:dio/dio.dart';

class DioErrorMessages {
  // DIO Exception Type Messages
  static const String connectionTimeout =
      'Connection timeout. Please check your internet connection and try again.';
  static const String sendTimeout =
      'Request timeout. The server is taking too long to respond.';
  static const String receiveTimeout =
      'Response timeout. The server response is taking too long.';
  static const String badCertificate =
      'Security certificate error. Please check your connection security.';
  static const String requestCancelled = 'Request was cancelled.';
  static const String defaultError =
      'An unexpected error occurred. Please try again.';

  // HTTP Status Code Messages
  static const String badRequest400 =
      'Invalid request. Please check your input and try again.';
  static const String unauthorized401 =
      'Authentication failed. Please log in again.';
  static const String forbidden403 =
      'Access denied. You don\'t have permission to perform this action.';
  static const String notFound404 = 'The requested resource was not found.';
  static const String methodNotAllowed405 =
      'Method not allowed. Please try a different approach.';
  static const String requestTimeout408 = 'Request timeout. Please try again.';
  static const String conflict409 =
      'Conflict occurred. The resource may have been modified.';
  static const String unprocessableEntity422 =
      'Invalid data provided. Please check your input.';
  static const String tooManyRequests429 =
      'Too many requests. Please wait a moment and try again.';
  static const String internalServerError500 =
      'Internal server error. Please try again later.';
  static const String badGateway502 =
      'Bad gateway. The server is temporarily unavailable.';
  static const String serviceUnavailable503 =
      'Service unavailable. Please try again later.';
  static const String gatewayTimeout504 =
      'Gateway timeout. The server is taking too long to respond.';

  // Generic HTTP Error Messages
  static const String clientError4xx =
      'Client error occurred. Please check your request and try again.';
  static const String serverError5xx =
      'Server error occurred. Please try again later.';
  static const String badResponseGeneric =
      'An error occurred while processing your request.';

  // Connection Error Messages
  static const String networkUnreachable =
      'No internet connection. Please check your network settings.';
  static const String connectionRefused =
      'Cannot connect to server. Please try again later.';
  static const String hostLookupFailed =
      'Cannot reach server. Please check your internet connection.';
  static const String socketException =
      'Network connection failed. Please check your internet connection.';
  static const String connectionErrorGeneric =
      'Connection failed. Please check your internet connection and try again.';

  // Unknown Error Messages
  static const String socketError =
      'Network connection failed. Please check your internet connection.';
  static const String failedHostLookup =
      'Cannot reach server. Please check your internet connection.';
  static const String connectionClosed =
      'Connection was lost. Please try again.';
  static const String unknownErrorGeneric =
      'An unexpected error occurred. Please try again.';

  // Error Code Format
  static const String errorCodeFormat = ' (Error code: {code})';

  // Commonly used phrases for consistency
  static const String tryAgain = 'Please try again.';
  static const String tryAgainLater = 'Please try again later.';
  static const String checkInternet = 'Please check your internet connection.';
  static const String checkInput = 'Please check your input.';
  static const String logInAgain = 'Please log in again.';
  static const String waitAndTry = 'Please wait a moment and try again.';

    /// Handle bad response errors (4xx, 5xx status codes)
  static String getBadResponseMsg(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (statusCode) {
      case 400:
        return DioErrorMessages.badRequest400;
      case 401:
        return DioErrorMessages.unauthorized401;
      case 403:
        return DioErrorMessages.forbidden403;
      case 404:
        return DioErrorMessages.notFound404;
      case 405:
        return DioErrorMessages.methodNotAllowed405;
      case 408:
        return DioErrorMessages.requestTimeout408;
      case 409:
        return DioErrorMessages.conflict409;
      case 422:
        return DioErrorMessages.unprocessableEntity422;
      case 429:
        return DioErrorMessages.tooManyRequests429;
      case 500:
        return DioErrorMessages.internalServerError500;
      case 502:
        return DioErrorMessages.badGateway502;
      case 503:
        return DioErrorMessages.serviceUnavailable503;
      case 504:
        return DioErrorMessages.gatewayTimeout504;
      default:
        return _handleBasResponseMsg(statusCode);
    }
  }

  static String _handleBasResponseMsg(int? statusCode) {
    if (statusCode != null && statusCode >= 400 && statusCode < 500) {
      return DioErrorMessages.clientError4xx;
    } else if (statusCode != null && statusCode >= 500) {
      return DioErrorMessages.serverError5xx;
    }
    return DioErrorMessages.badResponseGeneric;
  }

  /// Handle connection errors
  static String getConnectionErrorMsg(DioException error) {
    final message = error.message?.toLowerCase() ?? '';

    if (message.contains('network is unreachable') ||
        message.contains('no address associated with hostname')) {
      return DioErrorMessages.networkUnreachable;
    } else if (message.contains('connection refused')) {
      return DioErrorMessages.connectionRefused;
    } else if (message.contains('host lookup failed')) {
      return DioErrorMessages.hostLookupFailed;
    } else if (message.contains('socket exception')) {
      return DioErrorMessages.socketException;
    }

    return DioErrorMessages.connectionErrorGeneric;
  }

  /// Handle unknown errors
  static String getUnknownErrorMsg(DioException error) {
    final message = error.message?.toLowerCase() ?? '';

    if (message.contains('socket')) {
      return DioErrorMessages.socketError;
    } else if (message.contains('failed host lookup')) {
      return DioErrorMessages.failedHostLookup;
    } else if (message.contains('connection closed')) {
      return DioErrorMessages.connectionClosed;
    }

    return DioErrorMessages.unknownErrorGeneric;
  }

}
