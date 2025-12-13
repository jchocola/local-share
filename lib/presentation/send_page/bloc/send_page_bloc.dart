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

class SendPageBlocEvent_connectToDevice extends SendPageBlocEvent {
  final BonsoirService service;

  SendPageBlocEvent_connectToDevice({required this.service});
}

class SendPageBlocEvent_sendFiles extends SendPageBlocEvent {
  final List<File> files;
  final bool useAck; // Whether to use ACK for reliability

  SendPageBlocEvent_sendFiles({required this.files, this.useAck = false});
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
  final BonsoirService service;

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

///
/// BLOC
///
class SendPageBloc extends Bloc<SendPageBlocEvent, SendPageBlocState> {
  final AndroidNearbyService nearbyService;
  List<NearbyDevice> peers = [];

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

        //Start listening to peers:
        nearbyService.nearbyService.getPeersStream().listen((event) {
          peers = event;
          logger.d('Peers $peers');
        });
      } catch (e) {
        emit(SendPageBlocState_error(message: e as APP_ERROR_SUCCESS));
      }
    });

    ///
    /// OPEN APP SETTING FOR ALLOW PERMISSION
    ///
    on<SendPageBlocEvent_openAppSettingForAllowPermisson>((event, emit) async {
      try {
        await nearbyService.openAppSetting();
      } catch (e) {
        emit(SendPageBlocState_error(message: e as APP_ERROR_SUCCESS));
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
        emit(SendPageBlocState_error(message: e as APP_ERROR_SUCCESS));
      }
    });

    ///
    /// ON RESTART DISCOVERY
    ///
    on<SendPageBlocEvent_restartDiscovery>((event, emit) async {});

    ///
    /// ON CONNECT TO DEVICE
    ///
    on<SendPageBlocEvent_connectToDevice>((event, emit) async {});

    ///
    /// ON SEND FILES
    ///
    on<SendPageBlocEvent_sendFiles>((event, emit) async {});
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
