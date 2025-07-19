import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModel {
  int? statusCode;
  String? message;
  Map<String, dynamic>? errors;
  dynamic data;
  ResponseModel({
    this.statusCode,
    this.message,
    this.errors,
    required this.data,
  });

  @override
  String toString() {
    return 'ResponseModel(statusCode: $statusCode, message: $message, data: $data, errors: $errors)';
  }

  factory ResponseModel.fromMap(Map<String, dynamic> map, int? statusCode) {
    return ResponseModel(
      message: map['message'] != null ? map['message'] as String : null,
      errors: map['errors'] ?? {},
      data: map['data'],
      statusCode: statusCode ?? 404,
    );
  }

  factory ResponseModel.fromJson(String source, int? statusCode) {
    return ResponseModel.fromMap(
      json.decode(source) as Map<String, dynamic>,
      statusCode,
    );
  }
}
