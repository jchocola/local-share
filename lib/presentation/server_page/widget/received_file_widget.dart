import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/main.dart';
import 'package:local_share/presentation/blocs/server_bloc.dart';
import 'package:local_share/presentation/server_page/widget/received_file_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

class ReceivedFileWidget extends StatelessWidget {
  const ReceivedFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.appPadding / 2,
        horizontal: AppConstant.appPadding,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.appBorder),
        color: theme.colorScheme.primary.withOpacity(0.2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Show the count of received files from the server repo
          BlocBuilder<ServerBloc, ServerBlocState>(
            builder: (context, state) {
              if (state is ServerBlocState_opened) {
                final receivedFilesCount = context
                    .watch<ServerBloc>()
                    .serverRepo
                    .getReceivedFilesCount();
                return Text('Received files ($receivedFilesCount)');

                // return StreamBuilder<int>(
                //   stream: context
                //       .watch<ServerBloc>()
                //       .serverRepo
                //       .getReceivedFilesCountStream(),
                //   builder: (context, snapshot) {
                //     if (snapshot.hasData) {
                //       return Text('Received files (${snapshot.data})');
                //     } else {
                //        return Text('Received files (0)');
                //     }
                //   },
                // );
              }
              return Text('Received files (0)');
            },
          ),
          TextButton(
            onPressed: () {
              // Show received files
              _showReceivedFiles(context);
            },
            child: Text('Show'),
          ),
        ],
      ),
    );
  }

  void _showReceivedFiles(BuildContext context) {
    // Show a dialog or navigate to a new screen with received files
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Received Files'),
          content: Container(
            width: double.maxFinite,
            child: ReceivedFilesList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class ReceivedFilesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerBloc, ServerBlocState>(
      builder: (context, state) {
        if (state is ServerBlocState_opened) {
          final receivedFiles = context
              .watch<ServerBloc>()
              .serverRepo
              .getReceivedFiles();

          if (receivedFiles.isEmpty) {
            return Center(child: Text('No received files'));
          }

          return ListView.builder(
            shrinkWrap: true,
            itemCount: receivedFiles.length,
            itemBuilder: (context, index) {
              final file = receivedFiles[index];
              return ReceivedFileCard(
                file: file,
                onPressed: () {
                  _openFile(file.path, context);
                },
              );
              // return ListTile(
              //   title: Text(file.name),
              //   subtitle: Text(
              //     '${_formatFileSize(file.size)} - ${_formatDateTime(file.receivedAt)}',
              //   ),
              //   trailing: IconButton(
              //     icon: Icon(Icons.download),
              //     onPressed: () {
              //       // Open the file using the system's default app
              //       _openFile(file.path, context);
              //     },
              //   ),
              // );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  // String _formatFileSize(int bytes) {
  //   if (bytes < 1024) return '$bytes B';
  //   if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  //   if (bytes < 1024 * 1024 * 1024)
  //     return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  //   return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  // }

  void _openFile(String filePath, BuildContext context) async {
    logger.d('Downloading file: $filePath');
    try {
      // Get server information to construct download URL
      final serverBloc = context.read<ServerBloc>();
      final serverRepo = serverBloc.serverRepo;

      // Get the server base URL (without the /receive path)
      final baseUrl = serverRepo.receiveUrl.replaceAll('/receive', '');

      // Extract filename from the file path
      final fileName = path.basename(filePath);

      // Construct the download URL
      final downloadUrl = '$baseUrl/files/$fileName';

      logger.d('Download URL: $downloadUrl');

      // Open the download URL in the browser to trigger download
      final uri = Uri.parse(downloadUrl);
      if (await launchUrl(uri)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Downloading ${fileName}')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not start download')));
      }
    } catch (e) {
      logger.e('Error downloading file: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error downloading file: $e')));
    }
  }
}
