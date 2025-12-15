// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/android_nearby_service.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main.dart';
import 'package:nearby_service/nearby_service.dart';

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

///
/// BLOC
///

class SendReceiveBloc extends Bloc<SendReceiveBlocEvent, SendReceiveBlocState> {
  final AndroidNearbyService _nearbyService = getIt<AndroidNearbyService>();
  StreamSubscription<List<NearbyDevice>>? _peersListener;

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
          emit(SendReceiveBlocDiscovering());
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
    on<SendReceiveBlocEvent_openWiFiSetting>((evet, emit) async {
      try {
        await _nearbyService.openNetworkSetting();
      } catch (e) {
        logger.e(e.toString());
      }
    });
  }
}
