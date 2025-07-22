import 'package:downloading_manager/core/constant/app_strings.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/core/widgets/primary_app_button.dart';
import 'package:flutter/material.dart';

class OngoingDownloadsHeader extends StatelessWidget {
  const OngoingDownloadsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          Icons.downloading_rounded,
          size: SizerUtil.setSp(24),
          color: context.colorScheme.primary,
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
          trailingIcon: Icons.keyboard_arrow_right_rounded,
          padding: EdgeInsets.only(left: 16.0, top: 10.0, bottom: 10.0),
          height: 36,
          txtColor: context.colorScheme.primary,
          onPressed: () {
            Navigator.pushNamed(context, '/all-downloads');
          },
        ),
      ],
    );
  }
}
