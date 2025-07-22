import 'package:downloading_manager/core/constant/app_strings.dart';
import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/helper.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:flutter/material.dart';

class AllDownloadScreen extends StatefulWidget {
  const AllDownloadScreen({super.key});

  @override
  State<AllDownloadScreen> createState() => _AllDownloadScreenState();
}

class _AllDownloadScreenState extends State<AllDownloadScreen> {
  bool hasAnimated = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        hasAnimated = true;
      });
    });
  }

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
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: dataItems.length,
                itemBuilder: (context, index) {
                  final myUser = dataItems[index];
                  return DownloadsListItem(
                    hasAnimated: hasAnimated,
                    myUser: myUser,
                    index: index,
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  AppBar buildScreenAppBar(BuildContext context) {
    return AppBar(title: const Text(AppStrings.downloads));
  }
}
