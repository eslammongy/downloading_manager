import 'package:downloading_manager/core/theme/app_colors.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
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
  final double height;
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 42,
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
    Color bgColor;
    Color textColor;
    Color borderColor;

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = context.colorScheme.primary;
        textColor = context.customColors.textPrimary;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.secondary:
        bgColor = context.colorScheme.surface;
        textColor = context.customColors.textPrimary;
        borderColor = context.customColors.borderColor;
        break;
      case ButtonVariant.outline:
        bgColor = context.colorScheme.surface;
        textColor = context.customColors.textPrimary;
        borderColor = AppColors.primary;
        break;
      case ButtonVariant.text:
        bgColor = Colors.transparent;
        textColor = context.customColors.textPrimary;
        borderColor = Colors.transparent;
        break;
    }

    // Adjust colors if disabled
    if (isDisabled) {
      bgColor = bgColor.withValues(alpha: 0.5);
      textColor = textColor.withValues(alpha: 0.5);
      //borderColor = borderColor.withValues(alpha: 0.5);
    }

    return Padding(
      padding: margin,
      child: ElevatedButton(
        onPressed: isDisabled
            ? null
            : () {
                HapticFeedback.mediumImpact();
                onPressed();
              },
        style: _buildStyle(bgColor, textColor, borderColor),
        child: _buildButtonBody(),
      ),
    );
  }

  Widget _buildButtonBody() {
    if (isLoading) {
      return _buildLoadingProgress(txtColor ?? Colors.white);
    }
    if (leadingIcon != null || trailingIcon != null) {
      return Row(
        mainAxisAlignment: mainAlignment,
        children: [
          if (leadingIcon != null) Icon(leadingIcon, size: iconSize),
          _buildButtonTitle(),
          if (trailingIcon != null) Icon(trailingIcon, size: iconSize),
        ],
      );
    }
    return _buildButtonTitle();
  }

  Text _buildButtonTitle() {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: txtColor ?? Colors.white,
      ),
    );
  }

  ButtonStyle _buildStyle(Color bgColor, Color textColor, Color borderColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: txtColor ?? textColor,
      elevation: variant == ButtonVariant.text ? 0 : 1,
      padding: padding,
      fixedSize: Size.fromHeight(height.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
        side: BorderSide(color: borderColor, width: 1.0),
      ),
    );
  }

  SizedBox _buildLoadingProgress(Color textColor) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(textColor),
      ),
    );
  }
}
