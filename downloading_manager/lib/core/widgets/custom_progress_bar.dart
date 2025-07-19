import 'package:flutter/material.dart';

class ProgressCircle extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final double size;
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final Widget? child;

  const ProgressCircle({
    super.key,
    required this.progress,
    this.size = 60.0,
    this.color = const Color(0xFF4A6FE3),
    this.backgroundColor = const Color(0xFFE5E7EB),
    this.strokeWidth = 8.0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background circle
          Center(
            child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(backgroundColor),
              ),
            ),
          ),
          // Progress circle
          Center(
            child: SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          // Child widget (e.g., percentage text)
          if (child != null) Center(child: child!),
        ],
      ),
    );
  }
}
