import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:local_share/main.dart';

class FileSender {
  final WebSocket? socket;
  final File file; // only for 1 file

  final int chunkSize = 64 * 1024; // // 64KB

  bool isCanceled = false;
  int totalChunks = 0;

  FileSender(this.socket, {required this.file});

  Future<void> sendSingleFileWithoutAck() async {
    if (socket == null) {
      return;
    }

    final fileName = file.uri.pathSegments.last; // file name
    final fileLength = await file.length(); // file size
    totalChunks = (fileLength / chunkSize).ceil(); // total chunk

    // Socket send init
    // 1. Отправляем метаданные
    socket!.add(
      jsonEncode({
        'type': 'file_init',
        'data': {
          'fileName': fileName,
          'size': fileLength,
          'totalChunks': totalChunks,
          'transferId': DateTime.now().millisecondsSinceEpoch.toString()
        },
      }),
    );

    // 2. Открываем файл асинхронно
    final rafStream = file.openRead();
    int chunkIndex = 0;
    int bytesSent = 0;

    // final raf = file.openSync();

    try {
      // 3. Читаем и отправляем чанки
      await for (final chunk in rafStream) {
        if (isCanceled == true) {
          throw Exception('Передача отменена');
        }

        // Разбиваем на чанки нужного размера
        for (int i = 0; i < fileLength; i += chunkSize) {
          final end = i + chunkSize < fileLength ? i + chunkIndex : fileLength;

          final chunkData = chunk.sublist(i, end);
          // Отправляем чанк
          socket?.add(
            jsonEncode({
              'type': 'file_chunk',
              'chunkIndex': chunkIndex,
              'totalChunks': totalChunks,
              'data': base64Encode(chunkData),
            }),
          );

          bytesSent += chunkData.length;
          chunkIndex++;

          final progress = bytesSent / fileLength;

          logger.i('Отправлен чанк $chunkIndex/$totalChunks');

          // Небольшая пауза для избежания перегрузки
          await Future.delayed(Duration(milliseconds: 10));
        }
      }

      // 4. Отправляем завершение
      socket!.add(jsonEncode({'type': 'file_end'}));
    } catch (e) {
      // Уведомляем об ошибке
      socket?.add(jsonEncode({'type': 'file_error', 'error': e.toString()}));
    }
  }

  ///
  /// SEND SINGLE WITH ACK
  ///
  Future<void> sendSingleFileWithAck() async {
    final fileLength = await file.length();
    final totalChunks = (fileLength / chunkSize).ceil();

    final fileName = file.uri.pathSegments.last; // file name

    // Socket send init
    // 1. Отправляем метаданные
    socket!.add(
      jsonEncode({
        'type': 'file_init',
        'data': {
          'fileName': fileName,
          'size': fileLength,
          'totalChunks': totalChunks,
        },
      }),
    );

    // 2. Открываем файл асинхронно
    final rafStream = file.openRead();
    int chunkIndex = 0;

    await for (final chunk in rafStream) {
      if (isCanceled == true) {
        throw Exception('Передача отменена');
      }

      // Разбиваем на чанки нужного размера

      for (int i = 0; i < fileLength; i += chunkSize) {
        bool chunkSent = false;
        int retryCount = 0;
        final end = i + chunkSize < fileLength ? i + chunkIndex : fileLength;
        final chunkData = chunk.sublist(i, end);

        while (!chunkSent && retryCount < 3) {
          // Сбрасываем completer для нового ожидания
          final currentAck = Completer<bool>();

          // Временная подписка на ACK для этого чанка
          final tempSub = socket?.listen((mesage) {
            try {
              final data = jsonDecode(mesage);

              if (data['type'] == 'chunk_ack' && data['chunkIndex'] == i) {
                currentAck.complete(true);
              }
            } catch (_) {}
          });

          // Отправляем чанк
          socket?.add(
            jsonEncode({
              'type': 'file_chunk',
              'chunkIndex': i,
              'data': base64Encode(chunkData),
            }),
          );

          // waiting ACK
          try {
            await currentAck.future.timeout((Duration(seconds: 2)));
            chunkSent = true;
            logger.i('Chunk $i sended');
          } catch (_) {
            retryCount++;
          }

          // cancel tempSub
          await tempSub?.cancel();
        }

        if (!chunkSent) {
          throw '';
        }
      }
    }
  }
}
