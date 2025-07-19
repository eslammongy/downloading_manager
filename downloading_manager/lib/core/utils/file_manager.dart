import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  const FileManager();
  String generateFileId(String url, String fileName) {
    return '${url.hashCode}_${fileName.hashCode}';
  }

  Future<void> openFile(String path) async {}
  Future<void> deleteFile(String path) async {}
  String getFileType({required String fileName}) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'jpg':
      case 'jpeg':
      case 'png':
      case 'gif':
      case 'bmp':
      case 'webp':
        return 'image';
      case 'mp4':
      case 'avi':
      case 'mov':
      case 'mkv':
      case 'wmv':
        return 'video';
      case 'mp3':
      case 'wav':
      case 'flac':
      case 'aac':
        return 'audio';
      case 'pdf':
        return 'document';
      case 'zip':
      case 'rar':
      case '7z':
        return 'archive';
      default:
        return 'file';
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
}

/// provide a singleton instance of `FileManager`
FileManager get fileManager => FileManager();
