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

///
/// BLOC
///

class SendReceiveBloc extends Bloc<SendReceiveBlocEvent, SendReceiveBlocState> {
  final AndroidNearbyService _nearbyService = getIt<AndroidNearbyService>();
  StreamSubscription<List<NearbyDevice>>? _peersListener;
  NearbyDeviceInfo? connectedDeviceInfo;
  NearbyDevice? connectedNearbyDevice;

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

      // Handle peers
      _peersListener = _nearbyService.nearbyService.getPeersStream().listen((
        event,
      ) {
        logger.d('Peers $event');
        if (event.isNotEmpty) {
          emit(SendReceiveBloc_foundedDevices(devices: event));
        } else {
          //emit(SendReceiveBlocDiscovering());
        }
      });
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
        // send files request to receviver
        await _nearbyService.sendFileRequest(
          files: event.filesInfo,
          receiver: connectedDeviceInfo!,
        );
        

         // start communitcate with other device
        await _nearbyService.nearbyService.startCommunicationChannel(
          NearbyCommunicationChannelData(
            connectedNearbyDevice!.info.id,
            messagesListener: NearbyServiceMessagesListener(
              onData: (ReceivedNearbyMessage message) async {
                // handle content
                final content = message.content;

                //1) Request for transferring files
                // Sender-> Receiver
                if (content is NearbyMessageFilesRequest) {
                  final request = content;

                  // confirm recevive or not
                  final bool accept = true;

                  //TODO
                  // notify ui
                  if (accept) {
                    emit(SendReceiveBloc_receiverConfirmedRequest());
                  }
                  {
                    emit(SendReceiveBloc_receiverDeniedRequest());
                  }

                  // get current connected device
                  if (connectedNearbyDevice != null) {
                    // send response to sender
                    await _nearbyService.sendFileResponse(
                      requestId: request.id,
                      isAccepted: accept,
                      receiver: connectedNearbyDevice!.info,
                    );
                  }
                }

                //2) Received response from recevier
                // Receiver -> sender
                if (content is NearbyMessageFilesResponse) {
                  final response = content;
                  if (response.isAccepted) {
                    // notify Sender (Receiver confirmed)
                  } else {
                    // Notify sender ,( receiver denied his request)
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
                  final targetDir = Directory(docDir.path + '/received_files');
                  if (!await targetDir.exists()) {
                    await targetDir.create(recursive: true);
                  }

                  final savedPaths = <String>[];

                  for (final received in pack.files) {
                    // received.path — путь во временной папке плагина
                    final src = File(received.path);
                    final filename = received.name;
                    final destPath = targetDir.path + filename;

                    // Копируем/перемещаем в постоянное хранилище
                    await src.copy(destPath);
                    savedPaths.add(destPath);

                    // Удаляем временный файл (по желанию)
                    try {
                      await src.delete();
                    } catch (_) {}

                    // Готово — можно уведомить UI, показать список savedPaths и т.п.
                    logger.e('Saved received files: $savedPaths');
                  }
                } catch (e, st) {
                  logger.e('Error handling received files pack: $e\n$st');
                }
              },
            ),
          ),
        );
      } catch (e) {}
    });
  }
}
