import 'package:downloading_manager/downloader/view_models/downloader_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DownloaderCubit extends Cubit<DownloadState> {
  DownloaderCubit() : super(DownloadState(status: DownloadStatus.initial));
}
