import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final String id;
  final String fileName;
  final String fileType;
  final String originalUrl;
  final String? filePath;
  final int totalBytes;

  const FileModel({
    required this.id,
    required this.fileName,
    required this.fileType,
    required this.originalUrl,
    required this.totalBytes,
    this.filePath,
  });
  FileModel copyWith({
    String? id,
    String? fileName,
    String? fileType,
    String? originalUrl,
    String? filePath,
    int? totalBytes,
  }) {
    return FileModel(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      fileType: fileType ?? this.fileType,
      originalUrl: originalUrl ?? this.originalUrl,
      filePath: filePath ?? this.filePath,
      totalBytes: totalBytes ?? this.totalBytes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fileName,
    fileType,
    originalUrl,
    filePath,
    totalBytes,
  ];
}
