import 'dart:io';

import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/network_repository_impl.dart';
import 'package:local_share/main.dart';
import 'package:uuid/uuid.dart';
/*
    Use this method for sending data via android to android ,
    main logic :
    
    Device A want to send to Device B:
    1) Device B open this socket server
    2) Device B open bonsoir service to broadcast about server info ( local ip and port)
    3) Device A , picked files , found device B via bonsoir discover and send picked files via websocket

 */

class EmbeddedSocketServerImpl {
  NetworkRepositoryImpl networkRepositoryImpl = NetworkRepositoryImpl.instance;

  HttpServer? server; // server

  int port = 4820; //port

  String? localIP;

  String deviceId = '';

  String socket_url = '';

  // WebSocket clients
  final Map<String, WebSocket> _clients = {};

  ///
  /// START SERVER
  ///
  Future<void> startServer({int port = 4820}) async {
    logger.i('Start websocket server : $port');

    // set port
    this.port = port;

    // get local IP
    localIP = await networkRepositoryImpl.getLocalIPAddress();
    logger.i('LocalIp $localIP');

    // Validate IP
    if (localIP == null || localIP!.isEmpty) {
      logger.e('No local IP address');
      throw APP_ERROR_SUCCESS.NOT_CONNECTED_WIFI;
    }

    //Close any  exsisting server
    await server?.close();

    // Bind server
    server = await HttpServer.bind(localIP, port);
    logger.i('Server bound to ${server?.address}: ${server?.port}');

    // set socket url
    socket_url = 'ws://$localIP:$port';
    logger.i('Socket URL : $socket_url');

    // Set server Handler
    server!.listen(_handleRequest);
    logger.i('Server listening started');
  }

  ///
  /// CLOSE SERVER
  ///
  Future<void> closeServer() async {
    logger.i('Closing server');
    await server?.close();
    logger.e('Server closed');
  }

  ///
  /// HANDLE REQUEST
  ///
  void _handleRequest(HttpRequest request) async {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      final ws = await WebSocketTransformer.upgrade(request);
      final clientID = const Uuid().v4();

      _clients[clientID] = ws;

      logger.i('Client connected $clientID');

      ws.listen((message) async {});
    }
  }
}
