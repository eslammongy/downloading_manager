import 'package:downloading_manager/core/theme/app_colors.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ButtonVariant { primary, secondary, outline, text }

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isDisabled;
  final EdgeInsets margin;
  final MainAxisAlignment mainAlignment;
  final Color? txtColor;
  final EdgeInsets padding;
  final double fontSize;
  final double iconSize;
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.fontSize = 16,
    this.iconSize = 20,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.mainAlignment = MainAxisAlignment.center,
    this.margin = const EdgeInsets.all(0),
    this.txtColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
        bgColor = context.colorScheme.surface;
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

    return Padding(
      padding: margin,
      child: ElevatedButton(
        onPressed: () {
          if (!isLoading && !isDisabled) {
            HapticFeedback.heavyImpact();
            onPressed();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: txtColor ?? textColor,
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
    );
  }
}
