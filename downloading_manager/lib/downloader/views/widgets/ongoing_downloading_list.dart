import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/downloading_progress_indicator.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/downloader/models/file_model.dart';
import 'package:flutter/material.dart';

class OngoingDownloadingList extends StatefulWidget {
  const OngoingDownloadingList({super.key});

  @override
  State<OngoingDownloadingList> createState() => _OngoingDownloadingListState();
}

class _OngoingDownloadingListState extends State<OngoingDownloadingList> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<FileModel> _items = dummyFileData;

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      scrollDirection: Axis.horizontal,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return OngoingDownloadingItem(
          item: _items[index],
          animation: animation,
          index: index,
        );
      },
    );
  }

  void _addItem() {
    final int index = _items.length;
    _items.insert(
      index,
      FileModel(
        fileName: 'New File ${index + 1}',
        fileType: 'application/octet-stream',
        totalBytes: 1024 * (index + 1),
        id: '',
        originalUrl: '', // Example size
      ),
    );
    _listKey.currentState!.insertItem(index);
  }
}

class OngoingDownloadingItem extends StatelessWidget {
  const OngoingDownloadingItem({
    super.key,
    required this.item,
    required this.animation,
    required this.index,
    this.onCancel,
  });
  final FileModel item;
  final Animation<double> animation;
  final int index;
  final void Function()? onCancel;

  @override
  Widget build(BuildContext context) {
    var tween = Tween<Offset>(begin: const Offset(-1.0, 1.0), end: Offset.zero);
    return SlideTransition(
      position: tween.animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      ),
      child: SizedBox(
        width: 260.w,
        child: Card(
          margin: EdgeInsets.only(right: 16.w, top: 8.h, bottom: 8.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded),
                    padding: EdgeInsets.zero,
                    onPressed:
                        onCancel ??
                        () {
                          // Handle cancel action
                        },
                  ),
                ),
                const DownloadingProgressIndicator(),
                SizerUtil.gapH(8),
                Text(item.fileName, style: context.textTheme.titleMedium),
                SizerUtil.gapH(8),
                Text(
                  'Size: ${FileDataHelper.formatBytes(item.totalBytes)}',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.customColors.textSecondary,
                  ),
                ),
                SizerUtil.gapH(12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
