import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:downloading_manager/core/utils/response_model.dart';

class NetworkClient {
  late final Dio _dioClient;
  String? _token;
  String? _locale;
  bool _isRefreshing = false;
  int retryCount = 0;

  String? get token => _token;
  set token(String? newToken) {
    _token = newToken;
    _updateHeaders();
  }

  String? get locale => _locale;
  set locale(String? newLocale) {
    _locale = newLocale;
    _updateHeaders();
  }

  NetworkClient({required String? token, required String? locale}) {
    _token = token;
    _locale = locale;
    _initDioClient();
  }

  void _initDioClient() {
    _dioClient = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 40),
        sendTimeout: Duration(seconds: 40),
        receiveTimeout: Duration(seconds: 40),
        baseUrl:" AppEndpoints.baseUrl",
        headers: {
          "Authorization": "$_token",
          "Content-type": "application/json",
          "x-language-code": _locale,
        },
        responseType: ResponseType.json,
        validateStatus: (_) {
          return true;
        },
      ),
    );

    _dioClient.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) async {
          if (_shouldRetry(response) && retryCount <= 2) {
            retryCount++;
            await _retryFailedRequest(response, handler);
          } else {
            return handler.next(response);
          }
        },
        onError: (DioException error, handler) async {
          return handler.next(error);
        },
      ),
    );
  }

  void _updateHeaders({String? token, String? locale}) {
    _dioClient.options.headers = {
      "Authorization": "${token ?? _token}",
      "Content-Type": "application/json",
      "x-language-code": locale ?? _locale,
    };
  }

  bool _shouldRetry(Response<dynamic>? response) {
    return response?.statusCode == 401 &&
        response?.data['error'] == 'Unauthorized';
  }

  /// This function mainly used to retry any failed request with the expired auth token
  Future<void> _retryFailedRequest(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    if (_isRefreshing) {
      final newResponse = await _dioClient.request(
        response.requestOptions.path,
        data: response.requestOptions.data,
        queryParameters: response.requestOptions.queryParameters,
        options: Options(
          method: response.requestOptions.method,
          headers: response.requestOptions.headers,
        ),
      );
      handler.resolve(newResponse);
      return;
    }
    _isRefreshing = true;
    try {
      final newResponse = await _dioClient.request(
        response.requestOptions.path,
        data: response.requestOptions.data,
        queryParameters: response.requestOptions.queryParameters,
        options: Options(
          method: response.requestOptions.method,
          headers: {
            "Content-type": "application/json",
            "x-language-code": locale,
          },
        ),
      );
      handler.resolve(newResponse);
    } catch (e) {
      handler.next(response);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response<dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      Response dioResponse = await _dioClient.post(
        path,
        data: jsonEncode(data),
        queryParameters: parameters,
      );
      return dioResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final dioGetResponse = await _dioClient.get(
        path,
        queryParameters: parameters,
      );
      return dioGetResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> putFormData(String path, FormData data) async {
    Response dioResponse = await _dioClient.put(path, data: data);
    ResponseModel response = ResponseModel.fromJson(
      dioResponse.toString(),
      dioResponse.statusCode,
    );
    return response;
  }

  Future<Response<dynamic>> delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      Response dioResponse = await _dioClient.delete(
        path,
        queryParameters: parameters,
        data: jsonEncode(data),
      );

      return dioResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response<dynamic>> put(String path, Map<String, dynamic>? data) async {
    try {
      Response dioResponse = await _dioClient.put(path, data: jsonEncode(data));
      return dioResponse;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getBytes(String path) async {
    Response dioGetResponse = await _dioClient.get(
      path,
      options: Options(responseType: ResponseType.bytes),
    );
    return dioGetResponse;
  }
}
