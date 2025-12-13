// ignore_for_file: camel_case_types

import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/android_nearby_service.dart';
import 'package:local_share/data/repo/bonsoir_discover_repository_impl.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main.dart';
import 'package:local_share/data/repo/server_client.dart';
import 'package:local_share/data/repo/file_sender.dart';
import 'dart:io';
import 'dart:async';

import 'package:nearby_service/nearby_service.dart';

///
/// EVENT
///
abstract class SendPageBlocEvent {}

class SendPageBlocEvent_startNearbyServiceDiscover extends SendPageBlocEvent {}

class SendPageBlocEvent_openAppSettingForAllowPermisson
    extends SendPageBlocEvent {}

class SendPageBlocEvent_openNetworkSettingForAllowPermisson
    extends SendPageBlocEvent {}

class SendPageBlocEvent_stopDiscover extends SendPageBlocEvent {}

class SendPageBlocEvent_connectToDevice extends SendPageBlocEvent {
  final NearbyDevice device;

  SendPageBlocEvent_connectToDevice({required this.device});
}

class SendPageBlocEvent_sendFiles extends SendPageBlocEvent {
  final List<File> files;

  SendPageBlocEvent_sendFiles({required this.files});
}

class SendPageBlocEvent_restartDiscovery extends SendPageBlocEvent {}

///
/// STATE
///
abstract class SendPageBlocState {}

class SendPageBlocState_init extends SendPageBlocState {}

class SendPageBlocState_discovering extends SendPageBlocState {}

class SendPageBlocState_BonsoirDiscoveryStartedEvent
    extends SendPageBlocState {}

class SendPageBlocState_NearbyDiscoveryServiceFoundPeers
    extends SendPageBlocState {
  final List<NearbyDevice> peers;

  SendPageBlocState_NearbyDiscoveryServiceFoundPeers({required this.peers});
}

class SendPageBlocState_connecting extends SendPageBlocState {
  final BonsoirService service;

  SendPageBlocState_connecting({required this.service});
}

class SendPageBlocState_connected extends SendPageBlocState {
  final NearbyDevice service;

  SendPageBlocState_connected({required this.service});
}

class SendPageBlocState_sending extends SendPageBlocState {
  final int totalFiles;
  final int sentFiles;
  final double progress;
  final String? currentFileName;

  SendPageBlocState_sending({
    required this.totalFiles,
    required this.sentFiles,
    required this.progress,
    this.currentFileName,
  });
}

class SendPageBlocState_sent extends SendPageBlocState {}

class SendPageBlocState_error extends SendPageBlocState {
  final APP_ERROR_SUCCESS message;

  SendPageBlocState_error({required this.message});
}

class SendPageBlocState_success extends SendPageBlocState {
  final APP_ERROR_SUCCESS message;

  SendPageBlocState_success({required this.message});
}

///
/// BLOC
///
class SendPageBloc extends Bloc<SendPageBlocEvent, SendPageBlocState> {
  final AndroidNearbyService nearbyService;
  List<NearbyDevice> peers = [];
  StreamSubscription<List<NearbyDevice>>? _peerSubscription;
  bool _isConnected = false;
  NearbyDevice? _connectedNearbyDevice;

  SendPageBloc({required this.nearbyService})
    : super(SendPageBlocState_init()) {
    ///
    /// ON START NEARBY DISCOVER
    ///
    on<SendPageBlocEvent_startNearbyServiceDiscover>((event, emit) async {
      try {
        await nearbyService.init();
        await nearbyService.startDiscover();
        emit(SendPageBlocState_discovering());

        // Cancel any existing subscription
        await _peerSubscription?.cancel();

        // Start listening to peers
        _peerSubscription = nearbyService.nearbyService.getPeersStream().listen(
          (event) {
            peers = event;
            logger.d('Peers $peers');
            if (peers.isNotEmpty) {
              add(SendPageBlocEvent_NearbyPeersUpdated(peers: peers));
            }
          },
        );
      } catch (e) {
        logger.e('Error starting nearby discovery: $e');
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED,
          ),
        );
      }
    });

    ///
    /// HANDLE PEER UPDATES
    ///
    on<SendPageBlocEvent_NearbyPeersUpdated>((event, emit) {
      emit(
        SendPageBlocState_NearbyDiscoveryServiceFoundPeers(peers: event.peers),
      );
    });

    ///
    /// OPEN APP SETTING FOR ALLOW PERMISSION
    ///
    on<SendPageBlocEvent_openAppSettingForAllowPermisson>((event, emit) async {
      try {
        await nearbyService.openAppSetting();
      } catch (e) {
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED,
          ),
        );
      }
    });

    ///
    /// OPEN NETWORK SETTING FOR ALLOW PERMISSION
    ///
    on<SendPageBlocEvent_openNetworkSettingForAllowPermisson>((
      event,
      emit,
    ) async {
      try {
        await nearbyService.openNetworkSetting();
      } catch (e) {
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_CONNECTED_WIFI,
          ),
        );
      }
    });

    ///
    /// ON STOP NEARBY DISCOVER
    ///
    on<SendPageBlocEvent_stopDiscover>((event, emit) async {
      try {
        await _peerSubscription?.cancel();
        await nearbyService.stopDiscover();
        peers = [];
        emit(SendPageBlocState_init());
      } catch (e) {
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED,
          ),
        );
      }
    });

    ///
    /// ON RESTART DISCOVERY
    ///
    on<SendPageBlocEvent_restartDiscovery>((event, emit) async {
      try {
        await _peerSubscription?.cancel();
        await nearbyService.stopDiscover();
        await nearbyService.startDiscover();
        emit(SendPageBlocState_discovering());
      } catch (e) {
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED,
          ),
        );
      }
    });

    ///
    /// ON CONNECT TO DEVICE
    ///
    on<SendPageBlocEvent_connectToDevice>((event, emit) async {
      try {
        //emit(SendPageBlocState_connecting(service: event.device));

        // Find the corresponding NearbyDevice
        // final nearbyDevice = peers.firstWhere(
        //   (device) => device.info.id == event.device.name,
        //   orElse: () => throw Exception('Device not found in peer list'),
        // );

        // Connect to the device
        final result = await nearbyService.nearbyService.connectById(
          event.device.info.id,
        );
        if (result) {
          _isConnected = true;
          _connectedNearbyDevice = event.device;

          // Start communication channel with required listeners
          await nearbyService.nearbyService.startCommunicationChannel(
            NearbyCommunicationChannelData(
              event.device.info.id,
              messagesListener: NearbyServiceMessagesListener(
                onCreated: () {
                  logger.i('Communication channel created');
                },
                onData: (data) {
                  logger.i('Received data: $data');
                },
                onError: (Object error, [StackTrace? stackTrace]) {
                  logger.e('Communication channel error: $error');
                },
              ),

              filesListener: NearbyServiceFilesListener(
                onData: (data) async {
                  
                },
              ),
            ),
          );

          emit(SendPageBlocState_connected(service: event.device));
          emit(
            SendPageBlocState_success(
              message: APP_ERROR_SUCCESS.FOUNDED_DEVICE,
            ),
          );
        } else {
          throw Exception('Failed to connect to device');
        }
      } catch (e) {
        logger.e('Error connecting to device: $e');
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED,
          ),
        );
      }
    });

    ///
    /// ON SEND FILES
    ///
    on<SendPageBlocEvent_sendFiles>((event, emit) async {
      // if not connected or connected device info == null 
      // show error

      if (!_isConnected || _connectedNearbyDevice == null) {
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED,
          ),
        );
        return;
      }

      try {
        final totalFiles = event.files.length; 
        int sentFiles = 0;

        // Get current device info for sender identification
        final senderInfo = await nearbyService.nearbyService
            .getCurrentDeviceInfo();
        if (senderInfo == null) {
          throw Exception('Unable to get current device info');
        }

        // Send file request
        final filePaths = event.files.map((file) => file.path).toList();
        final result = await nearbyService.nearbyService.get(
          onAndroid: (androidService) {
            return androidService.send(
              OutgoingNearbyMessage(
                content: NearbyMessageFilesRequest.create(
                  files: filePaths
                      .map((path) => NearbyFileInfo(path: path))
                      .toList(),
                ),
                receiver: NearbyDeviceInfo(
                  displayName:
                      "receiver", // This will be replaced with actual receiver info
                  id: _connectedNearbyDevice!.info.id,
                ),
              ),
            );
          },
          onDarwin: (darwinService) {
            return darwinService.send(
              OutgoingNearbyMessage(
                content: NearbyMessageFilesRequest.create(
                  files: filePaths
                      .map((path) => NearbyFileInfo(path: path))
                      .toList(),
                ),
                receiver: NearbyDeviceInfo(
                  displayName:
                      "receiver", // This will be replaced with actual receiver info
                  id: _connectedNearbyDevice!.info.id,
                ),
              ),
            );
          },
        );

        if (result != null && result) {
          // Update progress state
          emit(
            SendPageBlocState_sending(
              totalFiles: totalFiles,
              sentFiles: totalFiles,
              progress: 1.0,
              currentFileName: null,
            ),
          );

          emit(SendPageBlocState_sent());
          emit(
            SendPageBlocState_success(
              message: APP_ERROR_SUCCESS.FOUNDED_DEVICE,
            ),
          );
        } else {
          throw Exception('Failed to send files');
        }
      } catch (e) {
        logger.e('Error sending files: $e');
        emit(
          SendPageBlocState_error(
            message: APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED,
          ),
        );
      }
    });
  }

  @override
  Future<void> close() {
    _peerSubscription?.cancel();
    return super.close();
  }
}

// New event for handling peer updates
class SendPageBlocEvent_NearbyPeersUpdated extends SendPageBlocEvent {
  final List<NearbyDevice> peers;

  SendPageBlocEvent_NearbyPeersUpdated({required this.peers});
}
