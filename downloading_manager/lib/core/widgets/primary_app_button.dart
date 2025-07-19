import 'package:downloading_manager/core/theme/app_colors.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ButtonVariant { primary, secondary, outline, text }

enum ButtonSize { small, medium, large }

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isFullWidth;
  final bool isLoading;
  final bool isDisabled;
  final EdgeInsets margin;
  final MainAxisAlignment mainAlignment;
  final Color? txtColor;

  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.size = ButtonSize.medium,
    this.leadingIcon,
    this.trailingIcon,
    this.isFullWidth = false,
    this.isLoading = false,
    this.isDisabled = false,
    this.mainAlignment = MainAxisAlignment.center,
    this.margin = const EdgeInsets.all(0),
    this.txtColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = AppColors.primaryDark;
        textColor = Colors.white;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.secondary:
        bgColor = context.colorScheme.surface;
        textColor = Colors.white;
        borderColor = context.customColors.borderColor;
        break;
      case ButtonVariant.outline:
        bgColor = Colors.transparent;
        textColor = isDark
            ? AppColors.textPrimaryDark
            : AppColors.textPrimaryLight;
        borderColor = AppColors.primaryDark;
        break;
      case ButtonVariant.text:
        bgColor = Colors.transparent;
        textColor = txtColor ?? context.customColors.textPrimary;
        borderColor = Colors.transparent;
        break;
    }

    // Adjust colors if disabled
    if (isDisabled) {
      bgColor = bgColor.withValues(alpha: 0.5);
      textColor = textColor.withValues(alpha: 0.5);
      borderColor = borderColor.withValues(alpha: 0.5);
    }

    // Determine padding based on size
    EdgeInsets padding;
    double fontSize;
    double iconSize;

    switch (size) {
      case ButtonSize.small:
        padding = EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0);
        fontSize = 14.0;
        iconSize = 16.0;
        break;
      case ButtonSize.medium:
        padding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0);
        fontSize = 16.0;
        iconSize = 18.0;
        break;
      case ButtonSize.large:
        padding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0);
        fontSize = 18.0;
        iconSize = 20.0;
        break;
    }

    return Padding(
      padding: margin,
      child: SizedBox(
        width: isFullWidth ? double.infinity : null,
        child: ElevatedButton(
          onPressed: () {
            if (!isLoading && !isDisabled) {
              HapticFeedback.heavyImpact();
              onPressed();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: textColor,
            elevation: variant == ButtonVariant.text ? 0 : 1,
            padding: padding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: borderColor, width: 1.0),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: iconSize,
                  height: iconSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                )
              : Row(
                  mainAxisSize: isFullWidth
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  mainAxisAlignment: mainAlignment,
                  children: [
                    if (leadingIcon != null) ...[
                      Icon(leadingIcon, size: iconSize),
                      SizedBox(width: 8.0),
                    ],
                    Text(
                      text,
                      style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (trailingIcon != null) ...[
                      SizedBox(width: 8.0),
                      Icon(trailingIcon, size: iconSize),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}
