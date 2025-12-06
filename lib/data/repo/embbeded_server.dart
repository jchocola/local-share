import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/network_repository_impl.dart';
import 'package:local_share/main.dart';
import 'package:uuid/uuid.dart';

class EmbbededServerRepoImpl {
  NetworkRepositoryImpl networkRepositoryImpl = NetworkRepositoryImpl.instance;

  HttpServer? server;

  int port = 4820;

  String? localIP;

  String deviceName = 'my device name';

  String deviceId = const Uuid().v4();

  String _sendUrl = '';
  String _receiveUrl = '';

  String get sendUrl => _sendUrl;
  String get receiveUrl => _receiveUrl;

  // WebSocket connections
  final Map<String, WebSocket> _clients = {};

  /// Start server
  Future<void> start({int port = 4820}) async {
    this.port = port;

    localIP = await networkRepositoryImpl.getLocalIPAddress();

    if (localIP == null) {
      throw APP_ERROR_SUCCESS.NOT_CONNECTED_WIFI;
    }
    server = await HttpServer.bind(localIP, port);

    _sendUrl = 'http://${localIP}:$port/send';
    _receiveUrl = 'http://${localIP}:$port/receive';

    logger.e('${server?.address} + ${server?.port}');
    server!.listen(_handleRequest);
  }

  Future<void> close() async {
    await server?.close();
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

      switch (path) {
        case '/info':
          request.response
            ..headers.contentType = ContentType.json
            ..write(
              jsonEncode({'id': deviceId, 'name': deviceName, 'port': port}),
            )
            ..close();
          break;

        case '/send':
          // take sendfile
          final htmlFile = await rootBundle.loadString('assets/public/send.html');

          // if (!await htmlFile.exists()) {
          //   logger.e('File not exists');
          //   request.response
          //     ..statusCode = 404
          //     ..headers.contentType = ContentType.text
          //     ..write('404');
          // } else {
            request.response
              ..headers.contentType = ContentType.html
              ..write(htmlFile);
         // }

          request.response.close();

          break;

        case '/receive':
           // take sendfile
          final htmlFile = await rootBundle.loadString('assets/public/receive.html');

          // if (!await htmlFile.exists()) {
          //   logger.e('File not exists');
          //   request.response
          //     ..statusCode = 404
          //     ..headers.contentType = ContentType.text
          //     ..write('404');
          // } else {
            request.response
              ..headers.contentType = ContentType.html
              ..write(htmlFile);
         // }

          request.response.close();

          break;

        default:
          request.response
            ..statusCode = HttpStatus.notFound
            ..write('Not Found')
            ..close();
          break;
      }

      // if (path == '/info') {
      //   request.response
      //     ..headers.contentType = ContentType.json
      //     ..write(
      //       jsonEncode({'id': deviceId, 'name': deviceName, 'port': port}),
      //     )
      //     ..close();
      // } else {
      //   request.response
      //     ..statusCode = HttpStatus.notFound
      //     ..write('Not Found')
      //     ..close();
      // }
    }
  }

  ///singleton
  EmbbededServerRepoImpl._();

  static final EmbbededServerRepoImpl _instance = EmbbededServerRepoImpl._();
  static EmbbededServerRepoImpl get instance => _instance;
}


// import 'dart:convert';
// import 'dart:io';

// import 'package:local_share/main.dart';
// import 'package:uuid/uuid.dart';

// class EmbbededServer {
//   HttpServer? _server;

//   int port = 4820;

//   String deviceName = 'my device name';

//   String deviceId = const Uuid().v4();

//   // WebSocket connections
//   final Map<String, WebSocket> _clients = {};

//   /// Start server
//   Future<void> start({int port = 4820}) async {
//     this.port = port;
//     _server = await HttpServer.bind(InternetAddress.anyIPv4, port);

//     logger.e( '${_server?.address} + ${_server?.port}');
//     _server!.listen(_handleRequest);
//   }

//   Future<void> close() async {
//     await _server?.close();
//     logger.e('Server closed');
//   }

//   ///
//   /// HANDLE REQUEST
//   ///
//   void _handleRequest(HttpRequest request) async {
//     if (WebSocketTransformer.isUpgradeRequest(request)) {
//       final ws = await WebSocketTransformer.upgrade(request);
//       final clientId = const Uuid().v4();

//       _clients[clientId] = ws;

//       print('Client connected: $clientId');

//       ws.listen(
//         (message) async {
//           try {
//             final data = jsonDecode(message);

//             final type = data['type'];

//             switch (type) {
//               case 'ping':
//                 ws.add(jsonEncode({'type': 'pong'}));
//                 break;
//               default:
//                 break;
//             }
//           } catch (e) {
//             logger.e(e.toString());
//           }
//         },

//         onDone: () {
//           _clients.remove(clientId);
//         },
//         onError: () {
//           _clients.remove(clientId);
//         },
//       );
//     } else {
//       // Simple HTTP responses for discovery
//       final path = request.uri.path;

//       if (path == '/info') {
//         request.response
//           ..headers.contentType = ContentType.json
//           ..write(
//             jsonEncode({'id': deviceId, 'name': deviceName, 'port': port}),
//           )
//           ..close();
//       } else {
//         request.response
//           ..statusCode = HttpStatus.notFound
//           ..write('Not Found')
//           ..close();
//       }
//     }
//   }

//   ///singleton
//   EmbbededServer._();

//   static final EmbbededServer _instance = EmbbededServer._();
//   static EmbbededServer get instance => _instance;
// }

