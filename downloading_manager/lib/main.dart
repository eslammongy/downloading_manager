import 'package:downloading_manager/core/theme/app_theme.dart';
import 'package:downloading_manager/core/utils/screen_util.dart';
import 'package:downloading_manager/downloader/view_models/downloader_cubit.dart';
import 'package:downloading_manager/downloader/views/downloads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) { 
    SizerUtil.init(context);
    return MaterialApp(
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (_) => DownloaderCubit(),
        child: const DownloadsScreen(),
      ),
    );
  }
}
