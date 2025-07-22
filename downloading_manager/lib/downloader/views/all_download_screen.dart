import 'package:downloading_manager/core/constant/app_strings.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class AllDownloadScreen extends StatelessWidget {
  const AllDownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          children: [],
        ),
      ),
    );
  }

  AppBar buildScreenAppBar(BuildContext context) {
    return AppBar(title: const Text(AppStrings.downloads));
  }
}
