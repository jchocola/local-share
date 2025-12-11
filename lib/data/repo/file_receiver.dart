import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:crypto/crypto.dart';
import 'package:local_share/core/utils/format_file_size.dart';
import 'package:local_share/main.dart';

class FileReceiver {
  final WebSocket socket; // web socket
  final String? outPath; // save path

  // Состояние приема файла
  IOSink? _fileSink;
  File? _currentFile;
  String? _currentFileName;
  int? _expectedFileSize;
  int _receivedBytes = 0;
  int _receivedChunks = 0;
  int _totalChunks = 0;
  String? _transferId;

  // Хеш для проверки целостности
  Digest? _fileHash;
  List<int> _hashData = [];

  // Колбэки для UI
  final void Function(double progress)? onProgress;
  final void Function(File file)? onFileComplete;
  final void Function(String error)? onError;
  final void Function(Map<String, dynamic> metadata)? onFileStart;

  // Таймер для автоматического закрытия
  Timer? _inactivityTimer;

  // Буфер для сборки файла (если нужно собирать из чанков)
  final Map<int, List<int>> _chunkBuffer = {};

  // CONSTRCUTOR
  FileReceiver(
    this.socket, {
    required this.outPath,
    this.onProgress,
    this.onFileComplete,
    this.onError,
    this.onFileStart,
  }) {
    _startListening();
  }

  /// Start socket listening
  void _startListening() {
    socket.listen(
      _handleMessage,
      onDone: _handleDisconnect,
      onError: _handleError,
      cancelOnError: true,
    );

    // Запускаем таймер неактивности (30 секунд)
    _resetInactivityTimer();
  }

  // socket handle message
  Future<void> _handleMessage(dynamic message) async {
    _resetInactivityTimer();

    try {
      // decode data
      final data = jsonDecode(message);

      final type = data['type']; // type
      final payload = data['data'] ?? {}; //data

      switch (type) {
        case 'file_init':
          await _handleFileInit(payload);
          break;

        case 'file_chunk':
          await _handleFileChunk(payload);
          break;

        case 'file_end':
          await _handleFileEnd(payload);
          break;

        case 'file_cancel':
          await _handleFileCancel(payload);
          break;

        case 'file_error':
          await _handleFileError(payload);
          break;

        case 'file_resume':
          await _handleFileResume(payload);
          break;

        case 'ping':
          _sendPong();
          break;

        default:
          logger.e('Неизвестный тип сообщения: $type');
      }
    } catch (e) {
      _handleError('Ошибка обработки сообщения: $e');
    }
  }

  Future<void> _handleFileInit(dynamic payload) async {
    try {
      // Получаем метаданные
      _currentFileName = payload['fileName'];
      _expectedFileSize = payload['size'];
      _transferId =
          payload['transferId'] ??
          DateTime.now().millisecondsSinceEpoch.toString();

      _totalChunks = payload['totalChunks'] ?? 0;

      _receivedBytes = 0;
      _receivedChunks = 0;

      // Инициализируем хеш
      _hashData.clear();
      _fileHash = null;

      // Проверяем валидность имени файла
      if (_currentFileName == null || _currentFileName!.isEmpty) {
        throw Exception('Имя файла не указано');
      }

      // Очищаем директорию от предыдущих файлов
      await _ensureOutputDirectory();

      // Создаем путь для сохранения
      final safeFileName = _sanitizeFileName(_currentFileName!);
      final filePath = '$outPath/$safeFileName';

      // Проверяем, не существует ли уже такой файл
      final existingFile = File(filePath);
      if (await existingFile.exists()) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final newFileName =
            '${safeFileName.split('.').first}_$timestamp.${safeFileName.split('.').last}';
        _currentFileName = newFileName;
      }

      // Создаем файл
      _currentFile = File('$outPath/$_currentFileName');
      _fileSink = _currentFile!.openWrite();

      logger.i('📥 Начинаем прием файла: $_currentFileName');
      logger.i('Ожидаемый размер: ${formatFileSize(_expectedFileSize!)}');

      // Уведомляем о начале приема
      onFileStart?.call({
        'fileName': _currentFileName,
        'fileSize': _expectedFileSize,
        'transferId': _transferId,
        'totalChunks': _totalChunks,
        'receivedChunks': _receivedChunks,
        'startTime': DateTime.now().toIso8601String(),
      });

      // Отправляем подтверждение отправителю
      _sendAck('file_init_ack', {
        'transferId': _transferId,
        'fileName': _currentFileName,
        'status': 'ready',
      });
    } catch (e) {
      _handleError('Ошибка инициализации файла: $e');

      _sendAck('file_init_error', {
        'error': e.toString(),
        'transferId': _transferId,
      });
    }
  }

  Future<void> _handleFileChunk(Map<String, dynamic> payload) async {
    if (_fileSink == null || _currentFile == null) {
      _handleError('Попытка записать чанк без инициализации файла');
      return;
    }

    try {
      final chunkIndex = payload['chunkIndex'] ?? 0;
      final isLast = payload['isLast'] ?? false;
      final chunkBase64 = payload['data'] as String?;

      if (chunkBase64 == null) {
        throw Exception('Чанк не содержит данных');
      }

      // Декодируем Base64
      final bytes = base64Decode(chunkBase64);

      final chunkSize = bytes.length;

      // Добавляем в буфер если нужно собрать файл по порядку
      if (payload['requireOrder'] == true) {
        _chunkBuffer[chunkIndex] = bytes;

        // Проверяем, можно ли записать последовательные чанки
        _writeBufferedChunks();
      } else {
        // Записываем сразу
        _fileSink!.add(bytes);
        _updateProgress(chunkSize);
      }

      // Обновляем хеш
      _hashData.addAll(bytes);

      // Отправляем подтверждение получения чанка
      _sendAck('chunk_ack', {
        'transferId': _transferId,
        'chunkIndex': chunkIndex,
        'receivedBytes': _receivedBytes,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });

      _receivedChunks++;

      // Если это последний чанк
      if (isLast) {
        await _fileSink!.flush();
        print('✅ Последний чанк получен');
      }
    } catch (e) {
      _handleError('Ошибка обработки чанка: $e');
      _sendAck('chunk_error', {
        'transferId': _transferId,
        'error': e.toString(),
      });
    }
  }

  void _writeBufferedChunks() {
    int nextChunk = 0;

    while (_chunkBuffer.containsKey(nextChunk)) {
      final bytes = _chunkBuffer.remove(nextChunk)!;
      _fileSink!.add(bytes);
      _updateProgress(bytes.length);
      nextChunk++;
    }
  }

  void _updateProgress(int bytesReceived) {
    _receivedBytes += bytesReceived;

    if (_expectedFileSize != null && _expectedFileSize! > 0) {
      final progress = _receivedBytes / _expectedFileSize!;
      onProgress?.call(progress.clamp(0.0, 1.0));

      // Выводим прогресс каждые 5%
      if (_receivedBytes % (_expectedFileSize! ~/ 20) == 0) {
        print(
          '📥 Прогресс: ${(progress * 100).toStringAsFixed(1)}% '
          '(${formatFileSize(_receivedBytes)} / ${formatFileSize(_expectedFileSize!)})',
        );
      }
    }
  }

  Future<void> _handleFileEnd(Map<String, dynamic> endData) async {
    try {
      // Завершаем запись
      await _fileSink?.flush();
      await _fileSink?.close();

      // Вычисляем хеш
      _fileHash = sha256.convert(_hashData);
      final fileHash = _fileHash!.toString();

      // Проверяем размер файла
      final actualFileSize = await _currentFile!.length();
      final expectedSize = _expectedFileSize ?? actualFileSize;

      if (actualFileSize != expectedSize) {
        logger.e(
          '⚠️  Размер файла не совпадает: '
          'ожидалось ${formatFileSize(expectedSize)}, '
          'получено ${formatFileSize(actualFileSize)}',
        );
      }

      logger.i('✅ Файл успешно сохранен:');
      logger.i('   Путь: ${_currentFile!.path}');
      logger.i('   Размер: ${formatFileSize(actualFileSize)}');
      logger.i('   Чанков: $_receivedChunks');
      logger.i('   Хеш: $fileHash');

      // Отправляем финальное подтверждение
      _sendAck('file_end_ack', {
        'transferId': _transferId,
        'fileName': _currentFileName,
        'fileSize': actualFileSize,
        'receivedBytes': _receivedBytes,
        'receivedChunks': _receivedChunks,
        'fileHash': fileHash,
        'timestamp': DateTime.now().toIso8601String(),
      });

      // Уведомляем UI
      onFileComplete?.call(_currentFile!);

      // Сбрасываем состояние
      _resetState();
    } catch (e) {
      _handleError('Ошибка завершения файла: $e');
    }
  }

  Future<void> _handleFileCancel(Map<String, dynamic> cancelData) async {
    final reason = cancelData['reason'] ?? 'Не указана';

    logger.e('❌ Прием файла отменен: $reason');

    // Закрываем файл
    await _fileSink?.close();

    // Удаляем частично записанный файл
    if (_currentFile != null && await _currentFile!.exists()) {
      await _currentFile!.delete();
      logger.i('🗑️  Частичный файл удален');
    }

    _resetState();

    onError?.call('Передача отменена: $reason');
  }

  Future<void> _handleFileError(Map<String, dynamic> errorData) async {
    final error = errorData['error'] ?? 'Неизвестная ошибка';

    logger.e('❌ Ошибка от отправителя: $error');

    // Закрываем файл
    await _fileSink?.close();

    onError?.call(error);
  }

  Future<void> _handleFileResume(Map<String, dynamic> resumeData) async {
    // Реализация возобновления прерванной передачи
    final transferId = resumeData['transferId'];
    final byteOffset = resumeData['byteOffset'] ?? 0;

    print('🔄 Возобновление передачи $transferId с байта $byteOffset');

    // Можно реализовать докачку файла
    _sendAck('resume_ack', {
      'transferId': transferId,
      'byteOffset': byteOffset,
      'canResume': true,
    });
  }

  void _sendPong() {
    _sendRaw({
      'type': 'pong',
      'data': {'timestamp': DateTime.now().millisecondsSinceEpoch},
    });
  }

  void _sendAck(String type, Map<String, dynamic> data) {
    _sendRaw({'type': type, 'data': data});
  }

  void _sendRaw(Map<String, dynamic> message) {
    try {
      if (socket.readyState == WebSocket.open) {
        socket.add(jsonEncode(message));
      }
    } catch (e) {
      print('Ошибка отправки подтверждения: $e');
    }
  }

  Future<void> _ensureOutputDirectory() async {
    final dir = Directory(outPath!);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
  }

  String _sanitizeFileName(String fileName) {
    // Убираем опасные символы из имени файла
    return fileName.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(Duration(seconds: 30), () {
      print('⏰ Таймаут неактивности');
      _handleError('Таймаут неактивности');
      _cleanup();
    });
  }

  void _resetState() {
    _fileSink = null;
    _currentFile = null;
    _currentFileName = null;
    _expectedFileSize = null;
    _receivedBytes = 0;
    _receivedChunks = 0;
    _transferId = null;
    _hashData.clear();
    _fileHash = null;
    _chunkBuffer.clear();
    _inactivityTimer?.cancel();
    _totalChunks = 0;
  }

    void _handleDisconnect() {
    print('🔌 Соединение закрыто');
    
    if (_fileSink != null) {
      print('⚠️  Соединение разорвано во время приема файла');
      onError?.call('Соединение разорвано');
    }
    
    _cleanup();
  }

  void _handleError(dynamic error) {
    print('❌ Ошибка приемника: $error');
    onError?.call(error.toString());
    _cleanup();
  }


    Future<void> _cleanup() async {
    _inactivityTimer?.cancel();
    
    try {
      await _fileSink?.flush();
      await _fileSink?.close();
    } catch (_) {}
    
    // Если файл неполный, удаляем его
    if (_currentFile != null && 
        _expectedFileSize != null && 
        _receivedBytes < _expectedFileSize! &&
        await _currentFile!.exists()) {
      await _currentFile!.delete();
      print('🗑️  Неполный файл удален');
    }
    
    _resetState();
  }



    // Публичные методы для управления

      Future<void> cancelReceiving() async {
    await _cleanup();
    _sendAck('receiver_cancel', {
      'reason': 'Отменено получателем',
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> pauseReceiving() async {
    await _fileSink?.flush();
    _sendAck('receiver_pause', {
      'transferId': _transferId,
      'receivedBytes': _receivedBytes,
    });
  }

   Future<void> resumeReceiving() async {
    if (_currentFile != null && _transferId != null) {
      _sendAck('receiver_resume', {
        'transferId': _transferId,
        'byteOffset': _receivedBytes,
      });
    }
  }

   Map<String, dynamic>? getCurrentTransferInfo() {
    if (_transferId == null) return null;
    
    return {
      'transferId': _transferId,
      'fileName': _currentFileName,
      'fileSize': _expectedFileSize,
      'receivedBytes': _receivedBytes,
      'receivedChunks': _receivedChunks,
      'progress': _expectedFileSize != null && _expectedFileSize! > 0
          ? (_receivedBytes / _expectedFileSize!).clamp(0.0, 1.0)
          : 0.0,
    };
  }

  void dispose() {
    _inactivityTimer?.cancel();
    socket.close();
    _cleanup();
  }
}
