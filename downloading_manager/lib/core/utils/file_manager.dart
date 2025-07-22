import 'dart:io';

import 'package:downloading_manager/core/utils/file_type.dart';
import 'package:downloading_manager/downloader/models/file_model.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  const FileManager();
  String generateFileId(String url, String fileName) {
    return '${url.hashCode}_${fileName.hashCode}';
  }

  Future<void> openFile(String path) async {}
  Future<void> deleteFile(String path) async {}
  FileType getFileType({required String fileName}) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg' || 'jpeg' || 'png' || 'gif' || 'bmp' || 'webp':
        return FileType.image;
      case 'mp4' || 'avi' || 'mov' || 'mkv' || 'wmv':
        return FileType.video;
      case 'mp3' || 'wav' || 'flac' || 'aac':
        return FileType.audio;
      case 'doc' || 'docx' || 'txt':
        return FileType.document;
      case 'pdf':
        return FileType.pdf;
      case 'zip' || 'rar' || '7z':
        return FileType.zip;
      case 'json':
        return FileType.json;
      case 'xls' || 'xlsx':
        return FileType.excel;
      case 'ppt' || 'pptx':
        return FileType.powerpoint;
      default:
        return FileType.file;
    }
  }

  Future<void> getFilePath(String path) async {}
  Future<void> getFileSize(String path) async {}
  Future<void> getFileName(String path) async {}
  Future<Directory> getDownloadingDirectory({
    required String fileType,
    String? customPath,
  }) async {
    if (customPath != null) {
      final customDir = Directory(customPath);
      if (!await customDir.exists()) {
        await customDir.create(recursive: true);
      }
      return customDir;
    }

    final baseDir = await getExternalStorageDirectory();
    final typeDir = Directory('${baseDir!.path}/Downloads/$fileType');

    if (!await typeDir.exists()) {
      await typeDir.create(recursive: true);
    }

    return typeDir;
  }

  // Get files by type
  List<FileModel> getFilesByType(String type) {
    return dummyFileData
        .where((file) => file.type.name.startsWith(type))
        .toList();
  }

  // Get downloaded files only
  List<FileModel> getDownloadedFiles() {
    return dummyFileData.where((file) => file.path != null).toList();
  }

  // Get pending downloads
  List<FileModel> getPendingDownloads() {
    return dummyFileData.where((file) => file.path == null).toList();
  }

  // Format file size
  String formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  // Get file extension
  String getFileExtension(String name) {
    return name.split('.').last.toLowerCase();
  }
}

/// provide a singleton instance of `FileManager`
FileManager get fileManager => FileManager();
