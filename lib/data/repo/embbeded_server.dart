import 'dart:convert';
import 'dart:io';

import 'package:local_share/main.dart';
import 'package:uuid/uuid.dart';

class EmbbededServer {
  HttpServer? _server;

  int port = 4820;

  String deviceName = 'my device name';

  String deviceId = const Uuid().v4();

  // WebSocket connections
  final Map<String, WebSocket> _clients = {};

  /// Start server
  Future<void> start({int port = 4820}) async {
    this.port = port;
    _server = await HttpServer.bind(InternetAddress.anyIPv4, port);

    logger.e( '${_server?.address} + ${_server?.port}');
    _server!.listen(_handleRequest);
  }

  Future<void> close() async {
    await _server?.close();
    logger.e('Server closed');
  }

  ///
  /// HANDLE REQUEST
  ///
  void _handleRequest(HttpRequest request) async {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      final ws = await WebSocketTransformer.upgrade(request);
      final clientId = const Uuid().v4();

      _clients[clientId] = ws;

      print('Client connected: $clientId');

      ws.listen(
        (message) async {
          try {
            final data = jsonDecode(message);

            final type = data['type'];

            switch (type) {
              case 'ping':
                ws.add(jsonEncode({'type': 'pong'}));
                break;
              default:
                break;
            }
          } catch (e) {
            logger.e(e.toString());
          }
        },

        onDone: () {
          _clients.remove(clientId);
        },
        onError: () {
          _clients.remove(clientId);
        },
      );
    } else {
      // Simple HTTP responses for discovery
      final path = request.uri.path;

      if (path == '/info') {
        request.response
          ..headers.contentType = ContentType.json
          ..write(
            jsonEncode({'id': deviceId, 'name': deviceName, 'port': port}),
          )
          ..close();
      } else {
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('Not Found')
          ..close();
      }
    }
  }

  ///singleton
  EmbbededServer._();

  static final EmbbededServer _instance = EmbbededServer._();
  static EmbbededServer get instance => _instance;
}
