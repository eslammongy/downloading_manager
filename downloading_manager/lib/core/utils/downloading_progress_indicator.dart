import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/downloading_progress.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class DownloadingProgressIndicator extends StatefulWidget {
  const DownloadingProgressIndicator({super.key});

  @override
  State<DownloadingProgressIndicator> createState() =>
      _DownloadingProgressIndicatorState();
}

class _DownloadingProgressIndicatorState
    extends State<DownloadingProgressIndicator>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100.w, 100.w),
      painter: CirclePainter(
        CircleDrawerOptions(
          drawType: CircleDrawType.fillWithBorder,
          borderColor: context.colorScheme.primary,
          fillColor: context.colorScheme.primary.withValues(alpha: 0.3),
          showProgressText: true,
          borderWidth: 10.w,
          progress: 0.8,
        ),
      ),
    );
  }
}
