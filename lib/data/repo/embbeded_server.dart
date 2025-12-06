import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/network_repository_impl.dart';
import 'package:local_share/main.dart';
import 'package:path/path.dart' as path;
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

  String get sendUrl {
    logger.i('Getting send URL: $_sendUrl');
    return _sendUrl;
  }
  
  String get receiveUrl {
    logger.i('Getting receive URL: $_receiveUrl');
    return _receiveUrl;
  }

  // Store reference to picked files
  List<File> pickedFiles = [];

  // Set picked files from the bloc
  void setPickedFiles(List<File> files) {
    logger.i('Setting ${files.length} files in server');
    for (var i = 0; i < files.length; i++) {
      logger.i('File $i: ${files[i].path}');
    }
    pickedFiles = files;
  }
  
  // Update picked files while server is running
  void updatePickedFiles(List<File> files) {
    pickedFiles = files;
  }

  // WebSocket connections
  final Map<String, WebSocket> _clients = {};

  /// Start server
  Future<void> start({int port = 4820}) async {
    logger.i('Starting server with port: $port');
    this.port = port;

    localIP = await networkRepositoryImpl.getLocalIPAddress();
    logger.i('Local IP: $localIP');

    if (localIP == null) {
      logger.e('No local IP found');
      throw APP_ERROR_SUCCESS.NOT_CONNECTED_WIFI;
    }
    
    // Validate IP
    if (localIP!.isEmpty) {
      logger.e('Local IP is empty');
      throw APP_ERROR_SUCCESS.NOT_CONNECTED_WIFI;
    }
    
    // Close any existing server
    await server?.close();
    
    server = await HttpServer.bind(localIP, port);
    logger.i('Server bound to ${server?.address}:${server?.port}');

    _sendUrl = 'http://${localIP}:$port/send';
    _receiveUrl = 'http://${localIP}:$port/receive';
    
    // Validate URLs
    if (_sendUrl.isEmpty) {
      logger.e('Send URL is empty');
    }
    
    if (_receiveUrl.isEmpty) {
      logger.e('Receive URL is empty');
    }
    
    logger.i('Send URL: $_sendUrl');
    logger.i('Receive URL: $_receiveUrl');

    logger.e('${server?.address} + ${server?.port}');
    server!.listen(_handleRequest);
    logger.i('Server listening started');
  }

  Future<void> close() async {
    logger.i('Closing server');
    await server?.close();
    logger.e('Server closed');
  }

  ///
  /// HANDLE REQUEST
  ///
  void _handleRequest(HttpRequest request) async {
    logger.i('Handling request: ${request.method} ${request.uri.path}');
    
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      logger.i('WebSocket upgrade request');
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
      logger.i('HTTP request path: $path');

      // Handle file downloads
      if (path.startsWith('/files/')) {
        final fileName = path.substring(7); // Remove '/files/' prefix
        logger.i('File download request for: $fileName');
        await _serveFile(request, fileName);
        return;
      }

      switch (path) {
        case '/info':
          logger.i('Info request');
          request.response
            ..headers.contentType = ContentType.json
            ..write(
              jsonEncode({'id': deviceId, 'name': deviceName, 'port': port}),
            )
            ..close();
          break;

        case '/send':
          logger.i('Send page request');
          // Serve dynamic send page with actual files
          await _serveSendPage(request);
          break;

        case '/receive':
          logger.i('Receive page request');
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
          logger.i('Not found: $path');
          request.response
            ..statusCode = HttpStatus.notFound
            ..write('Not Found')
            ..close();
          break;
      }
    }
  }

  // Serve the send page with actual files
  Future<void> _serveSendPage(HttpRequest request) async {
    try {
      logger.i('Serving send page with ${pickedFiles.length} files');
      final htmlFileResult = await rootBundle.loadString('assets/public/send.html');
      logger.i('HTML file loaded, length: ${htmlFileResult.length}');
      
      if (htmlFileResult.isEmpty) {
        logger.e('HTML file is empty');
        request.response
          ..statusCode = HttpStatus.internalServerError
          ..write('Internal Server Error: HTML file is empty')
          ..close();
        return;
      }
      
      String htmlContent = htmlFileResult;
      
      // Check if HTML contains the expected container
      if (!htmlContent.contains('<div class="files-container">')) {
        logger.e('HTML file does not contain files-container div');
        // Log first 500 characters or full content if shorter
        final snippetLength = htmlContent.length > 500 ? 500 : htmlContent.length;
        logger.i('HTML content snippet: ${htmlContent.substring(0, snippetLength)}');
        request.response
          ..statusCode = HttpStatus.internalServerError
          ..write('Internal Server Error: HTML structure is incorrect')
          ..close();
        return;
      }
      
      // Generate file list HTML
      StringBuffer fileCards = StringBuffer();
      
      if (pickedFiles.isEmpty) {
        logger.i('No files to serve');
        fileCards.write('''
          <div class="empty-state">
            <div class="empty-state-icon">📁</div>
            <p>No files available for download</p>
          </div>
        ''');
      } else {
        logger.i('Generating HTML for ${pickedFiles.length} files');
        for (var i = 0; i < pickedFiles.length; i++) {
          final file = pickedFiles[i];
          
          // Validate file
          if (file.path.isEmpty) {
            logger.w('Skipping empty file path at index $i');
            continue;
          }
          
          final fileName = path.basename(file.path); // Use path.basename instead of uri.pathSegments.last
          
          // Validate file name
          if (fileName.isEmpty) {
            logger.w('Skipping empty file name for file at index $i: ${file.path}');
            continue;
          }
          
          final fileExtension = fileName.split('.').last.toUpperCase();
          
          // Check if file exists
          if (!file.existsSync()) {
            logger.w('File does not exist: ${file.path}');
            continue;
          }
          
          final fileSize = await _formatFileSize(file);
          
          logger.i('Adding file: $fileName ($fileSize)');
          
          // Determine icon based on file type
          String icon = '📄';
          if (['JPG', 'JPEG', 'PNG', 'GIF', 'WEBP'].contains(fileExtension)) {
            icon = '🖼️';
          } else if (['MP4', 'AVI', 'MOV', 'WMV'].contains(fileExtension)) {
            icon = '🎬';
          } else if (['MP3', 'WAV', 'FLAC', 'AAC'].contains(fileExtension)) {
            icon = '🎵';
          } else if (['PDF'].contains(fileExtension)) {
            icon = '📑';
          } else if (['ZIP', 'RAR', '7Z', 'TAR'].contains(fileExtension)) {
            icon = '📦';
          }
          
          fileCards.write('''
            <div class="file-card">
              <div class="file-icon">$icon</div>
              <div class="file-info">
                <div class="file-name">$fileName</div>
                <div class="file-meta">
                  <span>$fileSize</span>
                  <span>$fileExtension</span>
                </div>
              </div>
              <div class="file-actions">
                <a href="/files/$fileName" class="download-btn" download="$fileName">Download</a>
              </div>
            </div>
          ''');
        }
      }
      
      logger.i('Generated file cards HTML length: ${fileCards.length}');
      
      // Insert file cards into the container div
      logger.i('Original HTML length: ${htmlContent.length}');
      logger.i('File cards HTML: $fileCards');
      
      // Check if the target string exists
      if (!htmlContent.contains('<div class="files-container">')) {
        logger.e('Could not find files-container div in HTML');
      }
      
      htmlContent = htmlContent.replaceFirst(
        '<div class="files-container">',
        '<div class="files-container">$fileCards'
      );
      logger.i('Modified HTML length: ${htmlContent.length}');
      
      // Verify the replacement worked
      if (fileCards.isNotEmpty && !htmlContent.contains('$fileCards')) {
        logger.e('File cards were not inserted into HTML');
      }
      
      logger.i('Generated HTML content length: ${htmlContent.length}');
      request.response
        ..headers.contentType = ContentType.html
        ..write(htmlContent);
      
      logger.i('Response headers set, content length: ${htmlContent.length}');
      await request.response.close();
      logger.i('Response closed');
    } catch (e, stackTrace) {
      logger.e('Error serving send page: $e\nStack trace: $stackTrace');
      request.response
        ..statusCode = HttpStatus.internalServerError
        ..write('Internal Server Error')
        ..close();
    }
  }

  // Serve actual file for download
  Future<void> _serveFile(HttpRequest request, String fileName) async {
    try {
      logger.i('Attempting to serve file: $fileName');
      logger.i('Available files: ${pickedFiles.map((f) => path.basename(f.path)).join(', ')}');
      
      // Validate file name
      if (fileName.isEmpty) {
        logger.e('Empty file name requested');
        request.response
          ..statusCode = HttpStatus.badRequest
          ..write('Bad Request')
          ..close();
        return;
      }
      
      // Find the file in picked files
      final file = pickedFiles.firstWhere(
        (f) => path.basename(f.path) == fileName,
        orElse: () => File(''),
      );
      
      // Validate that we found a file
      if (file.path.isEmpty) {
        logger.e('No file found matching: $fileName');
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('File not found')
          ..close();
        return;
      }
      
      if (file.existsSync()) {
        logger.i('File found, serving: $fileName');
        logger.i('Full file path: ${file.path}');
        
        // Check if file is readable
        try {
          final length = await file.length();
          logger.i('File size: $length bytes');
        } catch (e) {
          logger.e('Cannot read file size: $e');
        }
        
        // Set appropriate headers
        request.response
          ..headers.contentType = ContentType.binary
          ..headers.add('Content-Disposition', 'attachment; filename="$fileName"')
          ..headers.contentLength = await file.length();
        
        // Stream the file content
        final fileStream = file.openRead();
        await fileStream.pipe(request.response);
      } else {
        logger.i('File not found: $fileName');
        logger.i('Searched for basename: $fileName');
        for (var i = 0; i < pickedFiles.length; i++) {
          logger.i('Available file $i: ${path.basename(pickedFiles[i].path)} at ${pickedFiles[i].path}');
        }
        request.response
          ..statusCode = HttpStatus.notFound
          ..write('File not found: ${file.path}')
          ..close();
      }
    } catch (e, stackTrace) {
      logger.e('Error serving file: $e\nStack trace: $stackTrace');
      request.response
        ..statusCode = HttpStatus.internalServerError
        ..write('Internal Server Error')
        ..close();
    }
  }

  // Format file size for display
  Future<String> _formatFileSize(File file) async {
    try {
      final size = await file.length();
      logger.i('File size for ${path.basename(file.path)}: $size bytes');
      
      if (size < 0) {
        logger.e('Invalid file size: $size');
        return 'Unknown size';
      }
      
      if (size < 1024) return '$size B';
      if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
      if (size < 1024 * 1024 * 1024) return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
      return '${(size / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    } catch (e) {
      logger.e('Error getting file size: $e');
      return 'Unknown size';
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

