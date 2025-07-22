import 'dart:io';

import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/helper.dart';
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
          CircleAvatar(radius: 35, backgroundImage: AssetImage(myUser.image)),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(file.f, style: context.textTheme.titleMedium),
              Text(
                myUser.name,
                style: context.textTheme.titleSmall?.copyWith(
                  color: context.customColors.textSecondary,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            myUser.name,
            style: context.textTheme.titleSmall?.copyWith(
              color: context.customColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
