import 'package:downloading_manager/core/constant/app_strings.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/core/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

class DownloaderActionsButton extends StatelessWidget {
  const DownloaderActionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppPrimaryButton(
          text: AppStrings.cancel,
          variant: ButtonVariant.outline,
          txtColor: context.colorScheme.error,
          padding: EdgeInsets.symmetric(
            horizontal: SizerUtil.setWidth(24),
            vertical: 10,
          ),

          onPressed: () {},
        ),
        SizerUtil.gapW(20),
        Expanded(
          child: AppPrimaryButton(
            text: AppStrings.download,
            isDisabled: true,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
