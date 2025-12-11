import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:local_share/data/repo/shared_prefs_repository_impl.dart';
import 'package:local_share/main.dart';

class FileSender {
  final SharedPrefsRepositoryImpl prefs = SharedPrefsRepositoryImpl.instance;

  final WebSocket? socket;
  final File file; // only for 1 file

  int chunkSize = 1; // // 1KB

  bool isCanceled = false;
  int totalChunks = 0;

  FileSender(this.socket, {required this.file});

  Future<void> sendSingleFileWithoutAck() async {
    final settedChunkSize =  prefs.getChunkSize();

    chunkSize = settedChunkSize * 1024;

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
          'transferId': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      }),
    );

    // 2. Открываем файл асинхронно
    final rafStream = file.openRead();
    int chunkIndex = 0;
    int bytesSent = 0;

    try {
      // 3. Читаем и отправляем чанки
      await for (final chunk in rafStream) {
        if (isCanceled == true) {
          throw Exception('Передача отменена');
        }

        // Разбиваем на чанки нужного размера
        int position = 0;
        while (position < chunk.length) {
          final end = (position + chunkSize < chunk.length) 
              ? position + chunkSize 
              : chunk.length;
          
          final chunkData = chunk.sublist(position, end);
          final isLastChunk = (chunkIndex == totalChunks - 1);
          
          // Отправляем чанк
          socket?.add(
            jsonEncode({
              'type': 'file_chunk',
              'chunkIndex': chunkIndex,
              'isLast': isLastChunk,
              'data': base64Encode(chunkData),
            }),
          );

          bytesSent += chunkData.length;
          chunkIndex++;

          final progress = bytesSent / fileLength;

          logger.i('Отправлен чанк $chunkIndex/$totalChunks');

          // Небольшая пауза для избежания перегрузки
          await Future.delayed(Duration(milliseconds: 10));
          
          position += chunkSize;
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
    final settedChunkSize =  prefs.getChunkSize();

    chunkSize = settedChunkSize * 1024;

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
          'transferId': DateTime.now().millisecondsSinceEpoch.toString(),
        },
      }),
    );

    // 2. Открываем файл асинхронно
    final rafStream = file.openRead();
    int chunkIndex = 0;

    try {
      await for (final chunk in rafStream) {
        if (isCanceled == true) {
          throw Exception('Передача отменена');
        }

        // Разбиваем на чанки нужного размера
        int position = 0;
        while (position < chunk.length) {
          final end = (position + chunkSize < chunk.length) 
              ? position + chunkSize 
              : chunk.length;
          
          final chunkData = chunk.sublist(position, end);
          final isLastChunk = (chunkIndex == totalChunks - 1);
          
          bool chunkSent = false;
          int retryCount = 0;

          while (!chunkSent && retryCount < 3) {
            // Сбрасываем completer для нового ожидания
            final currentAck = Completer<bool>();

            // Временная подписка на ACK для этого чанка
            StreamSubscription? tempSub;
            tempSub = socket?.listen((message) {
              try {
                final data = jsonDecode(message);

                if (data['type'] == 'chunk_ack' && data['chunkIndex'] == chunkIndex) {
                  currentAck.complete(true);
                }
              } catch (_) {}
            });

            // Отправляем чанк
            socket?.add(
              jsonEncode({
                'type': 'file_chunk',
                'chunkIndex': chunkIndex,
                'isLast': isLastChunk,
                'data': base64Encode(chunkData),
              }),
            );

            // waiting ACK
            try {
              await currentAck.future.timeout(Duration(seconds: 5));
              chunkSent = true;
              logger.i('Chunk $chunkIndex sent successfully');
            } catch (_) {
              retryCount++;
              logger.w('Retry $retryCount for chunk $chunkIndex');
            }

            // cancel tempSub
            await tempSub?.cancel();
          }

          if (!chunkSent) {
            throw Exception('Failed to send chunk $chunkIndex after 3 retries');
          }
          
          chunkIndex++;
          position += chunkSize;
        }
      }
      
      // Send file end
      socket!.add(jsonEncode({'type': 'file_end'}));
    } catch (e) {
      // Уведомляем об ошибке
      socket?.add(jsonEncode({'type': 'file_error', 'error': e.toString()}));
      rethrow;
    }
  }
}