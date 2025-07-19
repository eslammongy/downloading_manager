abstract class Failure implements Exception {
  const Failure({this.message, this.statusCode, this.code});
  final String? message;
  final int? statusCode;
  final String? code;

  @override
  String toString() => message ?? 'An error occurred';
}

class StorageFailure extends Failure {
  StorageFailure({super.message, super.statusCode, super.code});
}
