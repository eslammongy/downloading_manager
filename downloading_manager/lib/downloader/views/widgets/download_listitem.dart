import 'package:downloading_manager/core/constant/assets_manager.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/file_manager.dart';
import 'package:downloading_manager/core/utils/file_type.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/downloader/models/file_model.dart';
import 'package:flutter/material.dart';

class DownloadsListItem extends StatelessWidget {
  const DownloadsListItem({
    super.key,
    required this.hasAnimated,
    required this.file,
    required this.index,
  });

  final bool hasAnimated;
  final FileModel file;
  final int index;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 100.h,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18.0),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(14.r),
      ),
      duration: Duration(milliseconds: 200 + (index * 100)),
      curve: Curves.decelerate,
      transform: Matrix4.translationValues(
        hasAnimated ? 0 : SizerUtil.screenWidth,
        0,
        0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 35, backgroundImage: AssetImage(getFileImg())),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(file.name, style: context.textTheme.titleMedium),
              Text(
                file.type.name,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.customColors.textSecondary,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            fileManager.formatBytes(file.totalBytes),
            style: context.textTheme.titleSmall?.copyWith(
              color: context.customColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String getFileImg() {
    switch (file.type) {
      case FileType.image:
        return AssetsManager.imageFileImg;
      case FileType.video:
        return AssetsManager.videoFileImg;
      case FileType.audio:
        return AssetsManager.audioFileImg;
      case FileType.pdf:
        return AssetsManager.pdfFileImg;
      case FileType.document:
        return AssetsManager.docFileImg;
      case FileType.excel:
        return AssetsManager.excelFileImg;
      case FileType.powerpoint:
        return AssetsManager.powerPointFileImg;
      case FileType.zip:
        return AssetsManager.zipFileImg;
      case FileType.json:
        return AssetsManager.jsonFileImg;
      case FileType.file:
        return AssetsManager.otherFileImg;
    }
  }
}
