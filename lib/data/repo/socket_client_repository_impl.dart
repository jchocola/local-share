import 'dart:io';

import 'package:local_share/main.dart';

class SocketClienrRepositoryImpl {
  WebSocket? socket;
  Future<void> connect({required String socketUrl}) async {
    try {
      socket = await WebSocket.connect(socketUrl);
      logger.i('Connected web socket');
    } catch (e) {
      logger.e('Error to connect websocket $e');
    }
  }

  Future<void> disconnect() async {
    try {
      await socket?.close();
      socket = null;
    } catch (e) {
      logger.e(e.toString());
    }
  }
}
