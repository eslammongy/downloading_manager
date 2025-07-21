import 'package:downloading_manager/core/constant/app_strings.dart';
import 'package:downloading_manager/core/constant/assets_manager.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/core/widgets/custom_text_form_field.dart';
import 'package:downloading_manager/core/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController urlController = TextEditingController();
    final TextEditingController fileNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),

        actions: [
          AppPrimaryButton(
            text: AppStrings.downloads,
            variant: ButtonVariant.text,
            txtColor: context.colorScheme.primary,
            height: 36,
            padding: EdgeInsets.symmetric(
              horizontal: SizerUtil.setWidth(6),
              vertical: SizerUtil.setHeight(5),
            ),
            trailingIcon: Icons.keyboard_arrow_right_rounded,
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
          horizontal: SizerUtil.setWidth(16),
          vertical: SizerUtil.setHeight(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AssetsManager.downloadingImg,
              width: 120.w,
              fit: BoxFit.contain,
            ),
            SizerUtil.gapH(22),
            CustomTextFormField(
              inputType: TextInputType.url,
              controller: urlController,
              label: AppStrings.enterDownloadUrl,
            ),
            SizerUtil.gapH(16),
            CustomTextFormField(
              inputType: TextInputType.text,
              controller: fileNameController,
              label: AppStrings.enterFileName,
            ),
            SizerUtil.gapH(42),
            Row(
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
            ),
            SizerUtil.gapH(42),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.downloading_rounded,
                  size: SizerUtil.setSp(24),
                  color: context.customColors.priorityLow,
                ),
                SizerUtil.gapW(6),
                Text(
                  AppStrings.ongoing,
                  textAlign: TextAlign.left,
                  style: context.textTheme.titleMedium,
                ),
                const Spacer(),
                AppPrimaryButton(
                  text: AppStrings.seeAll,
                  variant: ButtonVariant.text,
                  height: 36,
                  txtColor: context.colorScheme.primary,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
