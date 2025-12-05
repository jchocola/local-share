import 'dart:io';

class ServerClient {
  WebSocket? socket;

  Future<void> connect({required String host, required int port}) async {
    final uri = Uri(scheme: 'ws', host: host, port: port, path: '/');
    socket = await WebSocket.connect(uri.toString());
  }

  Future<void> disconnect() async {
    await socket?.close();
    socket = null;
  }
}
