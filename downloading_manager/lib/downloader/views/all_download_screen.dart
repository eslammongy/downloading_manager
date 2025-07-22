import 'package:downloading_manager/core/constant/app_strings.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/downloader/models/file_model.dart';
import 'package:downloading_manager/downloader/views/widgets/download_listitem.dart';
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
                itemCount: dummyFileData.length,
                itemBuilder: (context, index) {
                  final file = dummyFileData[index];
                  return DownloadsListItem(
                    hasAnimated: hasAnimated,
                    file: file,
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
