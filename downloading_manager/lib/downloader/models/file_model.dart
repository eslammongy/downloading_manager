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

// Dummy data for testing
final List<FileModel> dummyFileData = [
  FileModel(
    id: '1',
    fileName: 'vacation_photo.jpg',
    fileType: 'image/jpeg',
    originalUrl: 'https://example.com/files/vacation_photo.jpg',
    totalBytes: 2457600, // ~2.4 MB
    filePath: '/storage/emulated/0/Download/vacation_photo.jpg',
  ),
  FileModel(
    id: '2',
    fileName: 'project_report.pdf',
    fileType: 'application/pdf',
    originalUrl: 'https://example.com/documents/project_report.pdf',
    totalBytes: 5242880, // 5 MB
    filePath: '/storage/emulated/0/Documents/project_report.pdf',
  ),
  FileModel(
    id: '3',
    fileName: 'presentation.pptx',
    fileType:
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    originalUrl: 'https://example.com/files/presentation.pptx',
    totalBytes: 15728640, // 15 MB
    filePath: null, // Not downloaded yet
  ),
  FileModel(
    id: '4',
    fileName: 'music_track.mp3',
    fileType: 'audio/mpeg',
    originalUrl: 'https://example.com/audio/music_track.mp3',
    totalBytes: 8388608, // 8 MB
    filePath: '/storage/emulated/0/Music/music_track.mp3',
  ),
  FileModel(
    id: '5',
    fileName: 'tutorial_video.mp4',
    fileType: 'video/mp4',
    originalUrl: 'https://example.com/videos/tutorial_video.mp4',
    totalBytes: 104857600, // 100 MB
    filePath: '/storage/emulated/0/Movies/tutorial_video.mp4',
  ),
  FileModel(
    id: '6',
    fileName: 'app_icon.png',
    fileType: 'image/png',
    originalUrl: 'https://example.com/images/app_icon.png',
    totalBytes: 51200, // 50 KB
    filePath: '/storage/emulated/0/Pictures/app_icon.png',
  ),
  FileModel(
    id: '7',
    fileName: 'spreadsheet.xlsx',
    fileType:
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    originalUrl: 'https://example.com/files/spreadsheet.xlsx',
    totalBytes: 1048576, // 1 MB
    filePath: null, // Not downloaded yet
  ),
  FileModel(
    id: '8',
    fileName: 'archive.zip',
    fileType: 'application/zip',
    originalUrl: 'https://example.com/files/archive.zip',
    totalBytes: 25165824, // 24 MB
    filePath: '/storage/emulated/0/Download/archive.zip',
  ),
  FileModel(
    id: '9',
    fileName: 'document.docx',
    fileType:
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    originalUrl: 'https://example.com/documents/document.docx',
    totalBytes: 3145728, // 3 MB
    filePath: '/storage/emulated/0/Documents/document.docx',
  ),
  FileModel(
    id: '10',
    fileName: 'logo.svg',
    fileType: 'image/svg+xml',
    originalUrl: 'https://example.com/images/logo.svg',
    totalBytes: 12288, // 12 KB
    filePath: null, // Not downloaded yet
  ),
  FileModel(
    id: '11',
    fileName: 'sample_data.json',
    fileType: 'application/json',
    originalUrl: 'https://api.example.com/data/sample_data.json',
    totalBytes: 204800, // 200 KB
    filePath: '/storage/emulated/0/Download/sample_data.json',
  ),
  FileModel(
    id: '12',
    fileName: 'installation_guide.txt',
    fileType: 'text/plain',
    originalUrl: 'https://example.com/docs/installation_guide.txt',
    totalBytes: 4096, // 4 KB
    filePath: '/storage/emulated/0/Documents/installation_guide.txt',
  ),
];

// Helper functions for testing
class FileDataHelper {
  // Get files by type
  static List<FileModel> getFilesByType(String fileType) {
    return dummyFileData
        .where((file) => file.fileType.startsWith(fileType))
        .toList();
  }

  // Get downloaded files only
  static List<FileModel> getDownloadedFiles() {
    return dummyFileData.where((file) => file.filePath != null).toList();
  }

  // Get pending downloads
  static List<FileModel> getPendingDownloads() {
    return dummyFileData.where((file) => file.filePath == null).toList();
  }

  // Format file size
  static String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Get file extension
  static String getFileExtension(String fileName) {
    return fileName.split('.').last.toLowerCase();
  }

  // Get file icon based on type
  static String getFileIcon(String fileType) {
    if (fileType.startsWith('image/')) return '🖼️';
    if (fileType.startsWith('video/')) return '🎥';
    if (fileType.startsWith('audio/')) return '🎵';
    if (fileType.contains('pdf')) return '📄';
    if (fileType.contains('document') || fileType.contains('word')) return '📝';
    if (fileType.contains('spreadsheet') || fileType.contains('excel')) {
      return '📊';
    }
    if (fileType.contains('presentation') || fileType.contains('powerpoint')) {
      return '📺';
    }
    if (fileType.contains('zip') || fileType.contains('archive')) return '📦';
    if (fileType.contains('json')) return '📋';
    if (fileType.contains('text')) return '📃';
    return '📁';
  }
}
