import 'package:downloading_manager/downloader/view_models/downloader_state.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: DownloadItemWidget(downloadState: DownloadState()));
  }
}

class DownloadItemWidget extends StatelessWidget {
  final DownloadState downloadState;

  const DownloadItemWidget({super.key, required this.downloadState});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildFileIcon(),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${downloadState.fileModel?.fileName}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _getStatusText(),
                      style: TextStyle(fontSize: 14, color: _getStatusColor()),
                    ),
                  ],
                ),
              ),
              _buildActionButton(context),
            ],
          ),
          const SizedBox(height: 12),
          _buildProgressSection(),
        ],
      ),
    );
  }

  Widget _buildFileIcon() {
    IconData iconData;
    Color iconColor;

    switch (downloadState.fileModel!.fileType) {
      case 'image':
        iconData = Icons.image;
        iconColor = Colors.blue;
        break;
      case 'video':
        iconData = Icons.video_file;
        iconColor = Colors.red;
        break;
      case 'audio':
        iconData = Icons.audio_file;
        iconColor = Colors.orange;
        break;
      case 'document':
        iconData = Icons.description;
        iconColor = Colors.green;
        break;
      case 'archive':
        iconData = Icons.archive;
        iconColor = Colors.purple;
        break;
      default:
        iconData = Icons.insert_drive_file;
        iconColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(iconData, color: iconColor, size: 24),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    switch (downloadState.status) {
      case DownloadStatus.downloading:
        return IconButton(
          icon: const Icon(Icons.cancel, color: Colors.red),
          onPressed: () {
            // context.read<DownloadCubit>().cancelDownload(downloadState.id);
          },
        );
      case DownloadStatus.completed:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.open_in_new, color: Colors.blue),
              onPressed: () {
                // Open file functionality
                //_openFile(downloadState.filePath!);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {},
            ),
          ],
        );
      case DownloadStatus.failed:
        return IconButton(
          icon: const Icon(Icons.refresh, color: Colors.orange),
          onPressed: () {
            // Retry download functionality
            _retryDownload(context);
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildProgressSection() {
    switch (downloadState.status) {
      case DownloadStatus.downloading:
        return Column(
          children: [
            LinearProgressIndicator(
              value: downloadState.progress,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(_getStatusColor()),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(downloadState.progress * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                if (downloadState.fileModel!.totalBytes > 0)
                  Text(
                    '${_formatBytes(downloadState.downloadedBytes)} / ${_formatBytes(downloadState.fileModel!.totalBytes)}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
              ],
            ),
          ],
        );
      case DownloadStatus.completed:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 16),
              const SizedBox(width: 8),
              Text(
                'Download completed',
                style: TextStyle(color: Colors.green, fontSize: 12),
              ),
            ],
          ),
        );
      case DownloadStatus.failed:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.error, color: Colors.red, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  downloadState.errorMessage ?? 'Download failed',
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  String _getStatusText() {
    switch (downloadState.status) {
      case DownloadStatus.initial:
        return 'Ready to download';
      case DownloadStatus.downloading:
        return 'Downloading...';
      case DownloadStatus.completed:
        return 'Completed';
      case DownloadStatus.failed:
        return 'Failed';
      case DownloadStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor() {
    switch (downloadState.status) {
      case DownloadStatus.initial:
        return Colors.grey;
      case DownloadStatus.downloading:
        return Colors.blue;
      case DownloadStatus.completed:
        return Colors.green;
      case DownloadStatus.failed:
        return Colors.red;
      case DownloadStatus.cancelled:
        return Colors.orange;
    }
  }

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  void _openFile(String filePath) async {
    // try {
    //   final result = await OpenFile.open(filePath);
    //   if (result.type != ResultType.done) {
    //     // Handle file opening error
    //     debugPrint('Could not open file: ${result.message}');
    //   }
    // } catch (e) {
    //   debugPrint('Error opening file: $e');
    // }
  }

  void _retryDownload(BuildContext context) {
    // Retry the download using stored URL
    // context.read<DownloadCubit>().downloadFile(
    //   url: downloadState.originalUrl,
    //   fileName: downloadState.fileName,
    // );
  }
}
