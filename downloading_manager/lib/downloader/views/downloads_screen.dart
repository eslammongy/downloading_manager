import 'package:downloading_manager/core/constant/app_strings.dart';
import 'package:downloading_manager/core/constant/assets_manager.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/core/widgets/custom_text_form_field.dart';
import 'package:downloading_manager/core/widgets/primary_app_button.dart';
import 'package:downloading_manager/downloader/views/widgets/downloader_actions_button.dart';
import 'package:downloading_manager/downloader/views/widgets/ongoing_downloading_list.dart';
import 'package:downloading_manager/downloader/views/widgets/ongoing_downloads_header.dart';
import 'package:flutter/material.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController urlController = TextEditingController();
    final TextEditingController fileNameController = TextEditingController();
    return Scaffold(
      appBar: buildScreenAppBar(context),
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
            const DownloaderActionsButton(),
            SizerUtil.gapH(42),
            const OngoingDownloadsHeader(),
            Expanded(child: const OngoingDownloadingList()),
            SizerUtil.gapH(22),
          ],
        ),
      ),
    );
  }

  AppBar buildScreenAppBar(BuildContext context) {
    return AppBar(
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
    );
  }
}
