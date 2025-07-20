import 'package:downloading_manager/downloader/view_models/downloader_cubit.dart';
import 'package:downloading_manager/downloader/view_models/downloader_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:BlocProvider(create: (_) => DownloaderCubit(), child: const DownloadsPage(),),
    );
  }
}

class DownloadsPage extends StatelessWidget {
  const DownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddDownloadDialog(context),
          ),
        ],
      ),
      body: BlocBuilder<DownloaderCubit, DownloadState>(
        builder: (context, downloads) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text(
                  'No downloads yet',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddDownloadDialog(BuildContext context) {
    final urlController = TextEditingController();
    final fileNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Download'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: urlController,
              decoration: const InputDecoration(
                labelText: 'URL',
                hintText: 'Enter download URL',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: fileNameController,
              decoration: const InputDecoration(
                labelText: 'File Name',
                hintText: 'Enter file name',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // if (urlController.text.isNotEmpty &&
              //     fileNameController.text.isNotEmpty) {
              //   context.read<DownloadCubit>().downloadFile(
              //     url: urlController.text,
              //     fileName: fileNameController.text,
              //   );
              //   Navigator.pop(context);
              // }
            },
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }
}
