import 'dart:convert';
import 'dart:io';

class FileSender {
  final WebSocket? socket;
  final File file;

  final int chunkSize = 64 * 1024; // // 64KB

  FileSender(this.socket, {required this.file});

  Future<void> send() async {
    if (socket == null) {
      return;
    }

    final fileName = file.uri.pathSegments.last;
    final length = await file.length();

    // Socket send init
    socket!.add(
      jsonEncode({
        'type': 'file_init',
        'data': {'fileName': fileName, 'size': length},
      }),
    );

    final raf = file.openRead();
    await for (final chunk in raf) {

    }

    socket!.add(jsonEncode({'type': 'file_end'}));
  }
}
