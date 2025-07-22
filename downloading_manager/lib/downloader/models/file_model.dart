import 'package:equatable/equatable.dart';

class FileModel extends Equatable {
  final String id;
  final String name;
  final String type;
  final String originalUrl;
  final String? path;
  final int totalBytes;

  const FileModel({
    required this.id,
    required this.name,
    required this.type,
    required this.originalUrl,
    required this.totalBytes,
    this.path,
  });
  FileModel copyWith({
    String? id,
    String? name,
    String? type,
    String? originalUrl,
    String? path,
    int? totalBytes,
  }) {
    return FileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      originalUrl: originalUrl ?? this.originalUrl,
      path: path ?? this.path,
      totalBytes: totalBytes ?? this.totalBytes,
    );
  }

  @override
  List<Object?> get props => [id, name, type, originalUrl, path, totalBytes];
}

// Dummy data for testing
final List<FileModel> dummyFileData = [
  FileModel(
    id: '1',
    name: 'vacation_photo.jpg',
    type: 'image/jpeg',
    originalUrl: 'https://example.com/files/vacation_photo.jpg',
    totalBytes: 2457600, // ~2.4 MB
    path: '/storage/emulated/0/Download/vacation_photo.jpg',
  ),
  FileModel(
    id: '2',
    name: 'project_report.pdf',
    type: 'application/pdf',
    originalUrl: 'https://example.com/documents/project_report.pdf',
    totalBytes: 5242880, // 5 MB
    path: '/storage/emulated/0/Documents/project_report.pdf',
  ),
  FileModel(
    id: '3',
    name: 'presentation.pptx',
    type:
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
    originalUrl: 'https://example.com/files/presentation.pptx',
    totalBytes: 15728640, // 15 MB
    path: null, // Not downloaded yet
  ),
  FileModel(
    id: '4',
    name: 'music_track.mp3',
    type: 'audio/mpeg',
    originalUrl: 'https://example.com/audio/music_track.mp3',
    totalBytes: 8388608, // 8 MB
    path: '/storage/emulated/0/Music/music_track.mp3',
  ),
  FileModel(
    id: '5',
    name: 'tutorial_video.mp4',
    type: 'video/mp4',
    originalUrl: 'https://example.com/videos/tutorial_video.mp4',
    totalBytes: 104857600, // 100 MB
    path: '/storage/emulated/0/Movies/tutorial_video.mp4',
  ),
  FileModel(
    id: '6',
    name: 'app_icon.png',
    type: 'image/png',
    originalUrl: 'https://example.com/images/app_icon.png',
    totalBytes: 51200, // 50 KB
    path: '/storage/emulated/0/Pictures/app_icon.png',
  ),
  FileModel(
    id: '7',
    name: 'spreadsheet.xlsx',
    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
    originalUrl: 'https://example.com/files/spreadsheet.xlsx',
    totalBytes: 1048576, // 1 MB
    path: null, // Not downloaded yet
  ),
  FileModel(
    id: '8',
    name: 'archive.zip',
    type: 'application/zip',
    originalUrl: 'https://example.com/files/archive.zip',
    totalBytes: 25165824, // 24 MB
    path: '/storage/emulated/0/Download/archive.zip',
  ),
  FileModel(
    id: '9',
    name: 'document.docx',
    type:
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
    originalUrl: 'https://example.com/documents/document.docx',
    totalBytes: 3145728, // 3 MB
    path: '/storage/emulated/0/Documents/document.docx',
  ),
  FileModel(
    id: '10',
    name: 'logo.svg',
    type: 'image/svg+xml',
    originalUrl: 'https://example.com/images/logo.svg',
    totalBytes: 12288, // 12 KB
    path: null, // Not downloaded yet
  ),
  FileModel(
    id: '11',
    name: 'sample_data.json',
    type: 'application/json',
    originalUrl: 'https://api.example.com/data/sample_data.json',
    totalBytes: 204800, // 200 KB
    path: '/storage/emulated/0/Download/sample_data.json',
  ),
  FileModel(
    id: '12',
    name: 'installation_guide.txt',
    type: 'text/plain',
    originalUrl: 'https://example.com/docs/installation_guide.txt',
    totalBytes: 4096, // 4 KB
    path: '/storage/emulated/0/Documents/installation_guide.txt',
  ),
];

// Helper functions for testing
class FileDataHelper {
  // Get files by type
  static List<FileModel> getFilesByType(String type) {
    return dummyFileData.where((file) => file.type.startsWith(type)).toList();
  }

  // Get downloaded files only
  static List<FileModel> getDownloadedFiles() {
    return dummyFileData.where((file) => file.path != null).toList();
  }

  // Get pending downloads
  static List<FileModel> getPendingDownloads() {
    return dummyFileData.where((file) => file.path == null).toList();
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
  static String getFileExtension(String name) {
    return name.split('.').last.toLowerCase();
  }

  // Get file icon based on type
  static String getFileIcon(String type) {
    if (type.startsWith('image/')) return '🖼️';
    if (type.startsWith('video/')) return '🎥';
    if (type.startsWith('audio/')) return '🎵';
    if (type.contains('pdf')) return '📄';
    if (type.contains('document') || type.contains('word')) return '📝';
    if (type.contains('spreadsheet') || type.contains('excel')) {
      return '📊';
    }
    if (type.contains('presentation') || type.contains('powerpoint')) {
      return '📺';
    }
    if (type.contains('zip') || type.contains('archive')) return '📦';
    if (type.contains('json')) return '📋';
    if (type.contains('text')) return '📃';
    return '📁';
  }
}
