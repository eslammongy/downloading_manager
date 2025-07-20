import 'package:downloading_manager/downloader/models/file_model.dart';
import 'package:equatable/equatable.dart';

enum DownloadStatus {
  initial,
  downloading,
  completed,
  failed,
  cancelled;

  bool get isInProgress => this == DownloadStatus.downloading;
  bool get isCompleted => this == DownloadStatus.completed;
  bool get isFailed => this == DownloadStatus.failed;
  bool get isCancelled => this == DownloadStatus.cancelled;
  bool get isInitial => this == DownloadStatus.initial;
  bool get isIdle => isInitial || isCompleted;
}

class DownloadState extends Equatable {
  final FileModel? fileModel;
  final String? originalUrl;
  final DownloadStatus status;
  final double progress;
  final String? errorMessage;
  final int downloadedBytes;

  const DownloadState({
    this.fileModel,
    this.originalUrl,
    this.status = DownloadStatus.initial,
    this.progress = 0.0,
    this.errorMessage,
    this.downloadedBytes = 0,
  });

  DownloadState copyWith({
    FileModel? fileModel,
    String? originalUrl,
    DownloadStatus? status,
    double? progress,
    String? errorMessage,
    int? downloadedBytes,
  }) {
    return DownloadState(
      fileModel: fileModel,
      originalUrl: originalUrl ?? this.originalUrl,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      errorMessage: errorMessage ?? this.errorMessage,
      downloadedBytes: downloadedBytes ?? this.downloadedBytes,
    );
  }

  @override
  List<Object?> get props => [
    originalUrl,
    status,
    progress,
    errorMessage,
    downloadedBytes,
  ];
}
