import 'package:downloading_manager/core/theme/app_colors.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.errorText,
    this.initialValue,
    this.label,
    required this.inputType,
    this.controller,
    this.hint,
    this.hasBorder = true,
    this.obscureText = false,
    this.readOnly = false,
    this.suffix,
    this.prefix,
    this.fontSize = 14,
    this.textColor = AppColors.textPrimaryDark,
    this.hintColor = AppColors.primaryLight,
    this.borderColor,
  });

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final String? errorText;
  final String? initialValue;
  final bool readOnly;
  final String? label;
  final String? hint;
  final bool obscureText;
  final Color? hintColor;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType inputType;
  final TextEditingController? controller;
  final bool hasBorder;
  final Color textColor;
  final double fontSize;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.customColors.textPrimary,
        ),
        cursorColor: AppColors.primaryDark,
        autocorrect: true,
        enableSuggestions: true,
        obscureText: obscureText,
        obscuringCharacter: "*",
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,

          contentPadding: EdgeInsets.only(left: 20, top: 16, bottom: 16),
          errorText: errorText,
          errorStyle: context.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w400,
            height: 0.8,
            color: context.colorScheme.error,
          ),
          suffixIcon: suffix,
          prefixIcon: prefix,
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged != null ? (value) => onChanged!(value) : null,
        onFieldSubmitted:
            onFieldSubmitted != null
                ? (value) => onFieldSubmitted!(value)
                : null,
      ),
    );
  }
}
