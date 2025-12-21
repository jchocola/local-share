// ignore_for_file: camel_case_types

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/android_nearby_service.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main.dart';
import 'package:nearby_service/nearby_service.dart';
import 'package:path_provider/path_provider.dart';

///
/// EVENT
///
abstract class SendReceiveBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendReceiveBlocEvent_nearbyServiceInit extends SendReceiveBlocEvent {}

class SendReceiveBlocEvent_nearbyServiceDiscover extends SendReceiveBlocEvent {}

class SendReceiveBlocEvent_nearbyServiceStopDiscover
    extends SendReceiveBlocEvent {}

class SendReceiveBlocEvent_openAppSetting extends SendReceiveBlocEvent {}

class SendReceiveBlocEvent_openWiFiSetting extends SendReceiveBlocEvent {}

class SendReceiveBlocEvent_connectDevice extends SendReceiveBlocEvent {
  final NearbyDevice device;

  SendReceiveBlocEvent_connectDevice({required this.device});
  @override
  List<Object?> get props => [device];
}

class SendReceiveBlocEvent_sendFilesRequest extends SendReceiveBlocEvent {
  final List<NearbyFileInfo> filesInfo;

  SendReceiveBlocEvent_sendFilesRequest({required this.filesInfo});

  @override
  List<Object?> get props => [filesInfo];
}

class SendReceiveBlocEvent_acceptIncomingRequest extends SendReceiveBlocEvent {
  final String requestId;

  SendReceiveBlocEvent_acceptIncomingRequest({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}

class SendReceiveBlocEvent_declineIncomingRequest extends SendReceiveBlocEvent {
  final String requestId;

  SendReceiveBlocEvent_declineIncomingRequest({required this.requestId});

  @override
  List<Object?> get props => [requestId];
}

///
/// STATE
///
abstract class SendReceiveBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendReceiveBlocInit extends SendReceiveBlocState {}

class SendReceiveBlocDiscovering extends SendReceiveBlocState {}

class SendReceiveBloc_notWifiNearbyServiceGranted
    extends SendReceiveBlocState {}

class SendReceiveBloc_notWifiConnected extends SendReceiveBlocState {}

class SendReceiveBloc_foundedDevices extends SendReceiveBlocState {
  final List<NearbyDevice> devices;
  SendReceiveBloc_foundedDevices({required this.devices});

  @override
  List<Object?> get props => [devices];
}

class SendReceiveBloc_ConnectedDevice extends SendReceiveBlocState {
  final NearbyDevice device;
  SendReceiveBloc_ConnectedDevice({required this.device});

  @override
  List<Object?> get props => [device];
}

class SendReceiveBloc_SomeOnWantToSendFile extends SendReceiveBlocState {}

class SendReceiveBloc_receiverConfirmedRequest extends SendReceiveBlocState {}

class SendReceiveBloc_receiverDeniedRequest extends SendReceiveBlocState {}

class SendReceiveBloc_IncomingFilesRequest extends SendReceiveBlocState {
  final NearbyMessageFilesRequest request;

  SendReceiveBloc_IncomingFilesRequest({required this.request});

  @override
  List<Object?> get props => [request.id];
}

class SendReceiveBloc_TransferProgress extends SendReceiveBlocState {
  final bool isSender;
  final int totalFiles;
  final int processedFiles;
  final double progress; // 0..1
  final String? currentFileName;

  SendReceiveBloc_TransferProgress({
    required this.isSender,
    required this.totalFiles,
    required this.processedFiles,
    required this.progress,
    this.currentFileName,
  });

  @override
  List<Object?> get props => [isSender, totalFiles, processedFiles, progress];
}

class SendReceiveBloc_TransferCompleted extends SendReceiveBlocState {
  final List<String> savedPaths;

  SendReceiveBloc_TransferCompleted({required this.savedPaths});

  @override
  List<Object?> get props => [savedPaths];
}

class SendReceiveBloc_TransferError extends SendReceiveBlocState {
  final String message;

  SendReceiveBloc_TransferError({required this.message});

  @override
  List<Object?> get props => [message];
}

///
/// BLOC
///

class SendReceiveBloc extends Bloc<SendReceiveBlocEvent, SendReceiveBlocState> {
  final AndroidNearbyService _nearbyService = getIt<AndroidNearbyService>();
  StreamSubscription<List<NearbyDevice>>? _peersListener;
  NearbyDeviceInfo? connectedDeviceInfo;
  NearbyDevice? connectedNearbyDevice;
  NearbyMessageFilesRequest? _pendingIncomingRequest;
  String? _lastSentRequestId;

  SendReceiveBloc() : super(SendReceiveBlocInit()) {
    ///
    /// NEARBY SERVICE INIT
    ///
    on<SendReceiveBlocEvent_nearbyServiceInit>((event, emit) async {
      try {
        // INIT PLUGIN
        await _nearbyService.init();

        final peersListener = _nearbyService.nearbyService.getPeersStream();

        // DISCOVER
        add(SendReceiveBlocEvent_nearbyServiceDiscover());
      } catch (e) {
        if (e == APP_EXCEPTION.NOT_WIFI_NEARBY_SERVICE_GRANTED) {
          emit(SendReceiveBloc_notWifiNearbyServiceGranted());
        }

        if (e == APP_EXCEPTION.NOT_CONNECTED_WIFI) {
          emit(SendReceiveBloc_notWifiConnected());
        }
        logger.e(e.toString());
      }
    });

    ///
    /// DISCOVER
    ///
    on<SendReceiveBlocEvent_nearbyServiceDiscover>((event, emit) async {
      // START DISCOVER
      await _nearbyService.startDiscover();

      emit(SendReceiveBlocDiscovering());

      await emit.forEach<List<NearbyDevice>>(
        _nearbyService.nearbyService.getPeersStream(),
        onData: (devices) {
          logger.d('Peers $devices');

          if (devices.isNotEmpty) {
            return SendReceiveBloc_foundedDevices(devices: devices);
          } else {
            return SendReceiveBlocDiscovering();
          }
        },
        onError: (e, _) {
          logger.e(e);
          return SendReceiveBlocDiscovering();
          // return SendReceiveBlocError(e.toString());
        },
      );

      // Handle peers
      // _peersListener = _nearbyService.nearbyService.getPeersStream().listen((
      //   event
      // )  {
      //   logger.d('Peers $event');

      //   if (event.isNotEmpty) {

      //     emit(SendReceiveBloc_foundedDevices(devices: event));
      //   } else {

      //   }
      // });
    });

    ///
    /// STOP DISCOVER
    ///
    on<SendReceiveBlocEvent_nearbyServiceStopDiscover>((event, emit) async {
      // START DISCOVER
      await _nearbyService.stopDiscover();

      // pause handle listener
      _peersListener?.pause();

      emit(SendReceiveBlocInit());
    });

    ///
    /// OPEN APP SETTING
    ///
    on<SendReceiveBlocEvent_openAppSetting>((event, emit) async {
      try {
        await _nearbyService.openAppSetting();
      } catch (e) {
        logger.e(e.toString());
      }
    });

    ///
    /// OPEN WIFI SETTING
    ///
    on<SendReceiveBlocEvent_openWiFiSetting>((event, emit) async {
      try {
        await _nearbyService.openNetworkSetting();
      } catch (e) {
        logger.e(e.toString());
      }
    });

    ///
    /// connect device
    ///
    on<SendReceiveBlocEvent_connectDevice>((event, emit) async {
      try {
        // connect device
        await _nearbyService.connectDevice(device: event.device);

        // set local variable
        connectedDeviceInfo = event.device.info;
        logger.d('Connected device info : ${connectedDeviceInfo?.id}');

        // listen connectedDevice
        _nearbyService.nearbyService
            .getConnectedDeviceStreamById(event.device.info.id)
            .listen((device) async {
              connectedNearbyDevice = device;
            });

        // notify ui
        emit(SendReceiveBloc_ConnectedDevice(device: event.device));
      } catch (e) {
        logger.e(e.toString());
      }
    });

    ///
    /// SEND FILES Request
    ///
    on<SendReceiveBlocEvent_sendFilesRequest>((event, emit) async {
      try {
        logger.i('Connected device info : ${connectedDeviceInfo?.displayName}');

      
        // notify UI that we have requested transfer and waiting for response
        emit(SendReceiveBloc_SomeOnWantToSendFile());
        logger.d('Notified someOne Want to Send file');

        // listen connectedDevice
        // _nearbyService.nearbyService
        //     .getConnectedDeviceStreamById(connectedDeviceInfo?.id)
        //     .listen((device) async {
        //       connectedNearbyDevice = device;
        //     });

        // 1. ПРОВЕРКА КАНАЛА
        // Если канал еще не запущен, его НУЖНО запустить ДО отправки файла
        try {
          // start communication channel to listen for responses and file events
          await _nearbyService.nearbyService.startCommunicationChannel(
            NearbyCommunicationChannelData(
              connectedNearbyDevice!.info.id,
              messagesListener: NearbyServiceMessagesListener(
                onData: (ReceivedNearbyMessage message) async {
                  final content = message.content;

                  // Incoming request (we are receiver)
                  if (content is NearbyMessageFilesRequest) {
                    final request = content;

                    // store pending request and notify UI to accept/decline
                    _pendingIncomingRequest = request;
                    emit(
                      SendReceiveBloc_IncomingFilesRequest(request: request),
                    );

                    // do NOT auto accept here; wait for UI to call accept event
                  }

                  // Response to our earlier request (we are sender)
                  if (content is NearbyMessageFilesResponse) {
                    final response = content;
                    if (_lastSentRequestId != null &&
                        response.id == _lastSentRequestId) {
                      if (response.isAccepted) {
                        emit(SendReceiveBloc_receiverConfirmedRequest());
                        // transfer should start automatically by plugin; show sending progress state
                        emit(
                          SendReceiveBloc_TransferProgress(
                            isSender: true,
                            totalFiles: event.filesInfo.length,
                            processedFiles: 0,
                            progress: 0.0,
                            currentFileName: null,
                          ),
                        );
                      } else {
                        emit(SendReceiveBloc_receiverDeniedRequest());
                      }
                    }
                  }
                },
              ),
              filesListener: NearbyServiceFilesListener(
                onData: (ReceivedNearbyFilesPack pack) async {
                  try {
                    // Обработка принятого пакета файлов (pack содержит уже сохранённые в tmp пути)
                    logger.d(
                      'Got files pack id = ${pack.id} , total = ${pack.files.length}',
                    );

                    // Получаем папку приложения (Documents) для сохранения
                    final docDir = await getApplicationDocumentsDirectory();
                    final targetDir = Directory(
                      docDir.path + '/received_files',
                    );
                    if (!await targetDir.exists()) {
                      await targetDir.create(recursive: true);
                    }

                    final savedPaths = <String>[];

                    int processed = 0;
                    for (final received in pack.files) {
                      // received.path — путь во временной папке плагина
                      final src = File(received.path);
                      final filename =
                          received.name ?? src.path.split('/').last;
                      final destPath = targetDir.path + '/' + filename;

                      // emit progress before copying current file
                      emit(
                        SendReceiveBloc_TransferProgress(
                          isSender: false,
                          totalFiles: pack.files.length,
                          processedFiles: processed,
                          progress:
                              processed /
                              (pack.files.length > 0 ? pack.files.length : 1),
                          currentFileName: filename,
                        ),
                      );

                      // Копируем/перемещаем в постоянное хранилище
                      await src.copy(destPath);
                      savedPaths.add(destPath);

                      // Удаляем временный файл (по желанию)
                      try {
                        await src.delete();
                      } catch (_) {}

                      processed += 1;

                      // emit progress after finishing this file
                      emit(
                        SendReceiveBloc_TransferProgress(
                          isSender: false,
                          totalFiles: pack.files.length,
                          processedFiles: processed,
                          progress:
                              processed /
                              (pack.files.length > 0 ? pack.files.length : 1),
                          currentFileName: null,
                        ),
                      );
                    }

                    // Готово — можно уведомить UI, показать список savedPaths и т.п.
                    logger.e('Saved received files: $savedPaths');
                    emit(
                      SendReceiveBloc_TransferCompleted(savedPaths: savedPaths),
                    );
                  } catch (e, st) {
                    logger.e('Error handling received files pack: $e\n$st');
                    emit(SendReceiveBloc_TransferError(message: e.toString()));
                  }
                },
              ),
            ),
          );
        } catch (e) {
          logger.e(
            'Failed to start communication channel after connect:' +
                e.toString(),
          );
        }
        
         // create and send files request to receiver and keep request id
        final requestId = await _nearbyService.sendFileRequest(
          files: event.filesInfo,
          receiver: connectedDeviceInfo!,
        );
        _lastSentRequestId = requestId;
        logger.d(_lastSentRequestId);


      } catch (e) {
        logger.e(e.toString());
        emit(SendReceiveBloc_TransferError(message: e.toString()));
      }
    });

    // Accept incoming request (receiver side)
    on<SendReceiveBlocEvent_acceptIncomingRequest>((event, emit) async {
      try {
        final pending = _pendingIncomingRequest;
        if (pending == null || pending.id != event.requestId) {
          emit(
            SendReceiveBloc_TransferError(message: 'No such incoming request'),
          );
          return;
        }

        // send positive response
        await _nearbyService.sendFileResponse(
          requestId: pending.id,
          isAccepted: true,
          receiver: connectedDeviceInfo!,
        );

        emit(SendReceiveBloc_receiverConfirmedRequest());

        // waiting for plugin to deliver files and filesListener to receive pack
      } catch (e) {
        logger.e(e.toString());
        emit(SendReceiveBloc_TransferError(message: e.toString()));
      }
    });

    // Decline incoming request (receiver side)
    on<SendReceiveBlocEvent_declineIncomingRequest>((event, emit) async {
      try {
        final pending = _pendingIncomingRequest;
        if (pending == null || pending.id != event.requestId) {
          emit(
            SendReceiveBloc_TransferError(message: 'No such incoming request'),
          );
          return;
        }

        await _nearbyService.sendFileResponse(
          requestId: pending.id,
          isAccepted: false,
          receiver: connectedDeviceInfo!,
        );

        emit(SendReceiveBloc_receiverDeniedRequest());
        _pendingIncomingRequest = null;
      } catch (e) {
        logger.e(e.toString());
        emit(SendReceiveBloc_TransferError(message: e.toString()));
      }
    });
  }
}
