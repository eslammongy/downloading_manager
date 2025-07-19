import 'dart:io';

import 'package:path_provider/path_provider.dart';

enum FileType { image, video, audio, document, archive, file }

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
      case 'pdf' || 'doc' || 'docx' || 'txt':
        return FileType.document;
      case 'zip' || 'rar' || '7z':
        return FileType.archive;
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
}

/// provide a singleton instance of `FileManager`
FileManager get fileManager => FileManager();
