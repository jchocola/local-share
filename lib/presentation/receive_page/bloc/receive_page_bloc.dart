// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/bonsoir_broadcast_repository_impl.dart';
import 'package:local_share/data/repo/embedded_socket.dart';
import 'package:local_share/data/repo/file_receiver.dart';
import 'package:local_share/data/repo/local_notification_repo_impl.dart';
import 'package:local_share/data/repo/shared_prefs_repository_impl.dart';
import 'package:local_share/main.dart';
import 'package:local_share/presentation/server_page/widget/received_file_card.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

///
/// EVENT
///
abstract class ReceivePageBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecievePageBlocEvent_ChangeVisiblity extends ReceivePageBlocEvent {}

///
/// STATE
///

abstract class ReceivePageBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReceivePageBlocState_initial extends ReceivePageBlocState {}

class ReceivePageBlocState_loading extends ReceivePageBlocState {}

class ReceivePageBlocState_loaded extends ReceivePageBlocState {
  final bool visible;
  ReceivePageBlocState_loaded({required this.visible});

  @override
  List<Object?> get props => [visible];

  ReceivePageBlocState_loaded copyWith({bool? visible}) {
    return ReceivePageBlocState_loaded(visible: visible ?? this.visible);
  }
}

class ReceivePageBlocState_error extends ReceivePageBlocState {
  final APP_ERROR_SUCCESS error;
  ReceivePageBlocState_error({required this.error});
}

///
/// BLOC
///
class ReceivePageBloc extends Bloc<ReceivePageBlocEvent, ReceivePageBlocState> {
  final BonsoirBroadcastRepositoryImpl bonsoirBroadcastRepositoryImpl;
  final EmbeddedSocketServerImpl socketServerRepoImpl;
  final LocalNotificationRepoImpl localNotificationRepoImpl;
  FileReceiver? fileReceiverRepoImpl;
  String? outPath;

  ReceivePageBloc({
    required this.bonsoirBroadcastRepositoryImpl,
    required this.socketServerRepoImpl,
    required this.localNotificationRepoImpl,
  }) : super(ReceivePageBlocState_loaded(visible: false)) {
    ///
    /// CHANGE VISIBILITY
    ///
    on<RecievePageBlocEvent_ChangeVisiblity>((event, emit) async {
      final currentState = state;

      logger.i('Changed visibility');

      try {
        if (currentState is ReceivePageBlocState_loaded) {
          // open or close bonsoir broadcast
          if (!currentState.visible == true) {
            final port = 3030;

            // Get download directory
            final directory = await getApplicationDocumentsDirectory();
            outPath = '${directory.path}/Downloads';

            // Create download directory if it doesn't exist
            final downloadDir = Directory(outPath!);
            if (!await downloadDir.exists()) {
              await downloadDir.create(recursive: true);
            }

            // show notification or not
            final showNotification = SharedPrefsRepositoryImpl.instance
                .getTransferNotification();

            // Set up socket connection handler
            void handleSocketConnection(WebSocket socket) {
              logger.i('WebSocket client connected');

              // Initialize file receiver when client connects
              fileReceiverRepoImpl = FileReceiver(
                socket,
                outPath: outPath,
                onProgress: (progress) {
                  logger.i('File transfer progress: ${progress * 100}%');
                },
                onFileComplete: (file) {
                  logger.i('File transfer completed: ${file.path}');

                  if (showNotification) {
                    localNotificationRepoImpl.showSimpleNotification(
                      title: 'Files transfer completed',
                      body: ''
                    );
                  }
                },
                onError: (error) {
                  logger.e('File transfer error: $error');
                   if (showNotification) {
                    localNotificationRepoImpl.showSimpleNotification(
                      title: 'File transfer error',
                      body: ''
                    );
                  }
                },
                onFileStart: (metadata) {
                  logger.i('File transfer started: $metadata');
                },
              );
            }

            // Set the connection handler on the existing socket server instance
            socketServerRepoImpl.onConnected = handleSocketConnection;

            // open socket server
            await socketServerRepoImpl.startServer(port: port);

            // open bonsoir broadcast
            await bonsoirBroadcastRepositoryImpl.broadcastInitialize(
              port: port,
            );
            await bonsoirBroadcastRepositoryImpl.broadcastStart();

            logger.i('Broadcast service started successfully');
          } else {
            await bonsoirBroadcastRepositoryImpl.broadcastStop();
            logger.i('Broadcast service stopped');
          }

          emit(currentState.copyWith(visible: !currentState.visible));
        }
      } catch (e, stackTrace) {
        logger.e('Error in ReceivePageBloc: $e\nStack trace: $stackTrace');
        emit(ReceivePageBlocState_error(error: e as APP_ERROR_SUCCESS));
        emit(ReceivePageBlocState_loaded(visible: false));
      }
    });
  }
}
