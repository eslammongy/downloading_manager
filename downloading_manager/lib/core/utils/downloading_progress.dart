import 'dart:math' as math;
import 'package:downloading_manager/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum CircleDrawType { borderOnly, fillOnly, fillWithBorder }

class CircleDrawerOptions {
  final CircleDrawType drawType;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final double progress; // 0.0 to 1.0
  final double startAngle; // In radians, 0 = top
  final bool clockwise;
  final bool showProgressText;
  final TextStyle? progressTextStyle;

  const CircleDrawerOptions({
    this.drawType = CircleDrawType.fillWithBorder,
    this.fillColor = AppColors.secondaryDark,
    this.borderColor = AppColors.secondaryDark,
    this.borderWidth = 12.0,
    this.progress = 1.0,
    this.startAngle = -math.pi / 2, // Start from top
    this.clockwise = true,
    this.showProgressText = false,
    this.progressTextStyle,
  });

  CircleDrawerOptions copyWith({
    CircleDrawType? drawType,
    Color? fillColor,
    Color? borderColor,
    double? borderWidth,
    double? progress,
    double? startAngle,
    bool? clockwise,
    bool? showProgressText,
    TextStyle? progressTextStyle,
  }) {
    return CircleDrawerOptions(
      drawType: drawType ?? this.drawType,
      fillColor: fillColor ?? this.fillColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      progress: progress ?? this.progress,
      startAngle: startAngle ?? this.startAngle,
      clockwise: clockwise ?? this.clockwise,
      showProgressText: showProgressText ?? this.showProgressText,
      progressTextStyle: progressTextStyle ?? this.progressTextStyle,
    );
  }
}

class CircleDrawer {
  static void drawCircle({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required CircleDrawerOptions options,
  }) {
    final rect = Rect.fromCircle(center: center, radius: radius);
    final clampedProgress = options.progress.clamp(0.0, 100.0);

    // Calculate sweep angle based on progress
    final sweepAngle = 2 * math.pi * clampedProgress;
    final actualSweepAngle = options.clockwise ? sweepAngle : -sweepAngle;

    switch (options.drawType) {
      case CircleDrawType.fillOnly:
        _drawFill(canvas, rect, options, actualSweepAngle);
        break;
      case CircleDrawType.borderOnly:
        _drawBorder(canvas, rect, options, actualSweepAngle);
        break;
      case CircleDrawType.fillWithBorder:
        _drawFill(canvas, rect, options, actualSweepAngle);
        _drawBorder(canvas, rect, options, actualSweepAngle);
        break;
    }
    // Draw progress text if enabled
    if (options.showProgressText) {
      _drawProgressText(canvas, center, options);
    }
  }

  static void _drawProgressText(
    Canvas canvas,
    Offset center,
    CircleDrawerOptions options,
  ) {
    final clampedProgress = options.progress.clamp(0.0, 1.0);

    // Format the progress text
    String progressText = '${(clampedProgress * 100).toInt()}%';

    // Default text style if none provided
    final textStyle =
        options.progressTextStyle ??
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        );

    // Create text painter
    final textPainter = TextPainter(
      text: TextSpan(text: progressText, style: textStyle),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    // Layout and paint the text
    textPainter.layout();

    // Calculate the position to center the text
    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }

  static void _drawFill(
    Canvas canvas,
    Rect rect,
    CircleDrawerOptions options,
    double sweepAngle,
  ) {
    final paint = Paint()
      ..color = options.fillColor
      ..style = PaintingStyle.fill;

    if (options.progress >= 1.0) {
      // Draw complete circle
      canvas.drawCircle(rect.center, rect.width / 2, paint);
    } else if (options.progress > 0.0) {
      // Draw arc for partial circle
      canvas.drawArc(rect, options.startAngle, sweepAngle, true, paint);
    }
  }

  static void _drawBorder(
    Canvas canvas,
    Rect rect,
    CircleDrawerOptions options,
    double sweepAngle,
  ) {
    final paint = Paint()
      ..color = options.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = options.borderWidth
      ..strokeCap = StrokeCap.round;

    if (options.progress >= 1.0) {
      // Draw complete circle border
      canvas.drawCircle(rect.center, rect.width / 2, paint);
    } else if (options.progress > 0.0) {
      // Draw arc for partial circle border
      canvas.drawArc(rect, options.startAngle, sweepAngle, false, paint);
    }
  }
}

// Example Custom Painter using the CircleDrawer utility
class CirclePainter extends CustomPainter {
  final CircleDrawerOptions options;

  CirclePainter(this.options);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - options.borderWidth;

    CircleDrawer.drawCircle(
      canvas: canvas,
      center: center,
      radius: radius,
      options: options,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.options != options;
  }
}
