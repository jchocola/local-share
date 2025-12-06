// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_share/data/model/device_info_model.dart';
import 'package:local_share/data/repo/device_info_repository_impl.dart';
import 'package:local_share/main.dart';

///
/// EVENT
///
abstract class CurrentDeviceBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentDeviceBlocEvent_load extends CurrentDeviceBlocEvent {}

///
/// STATE
///
abstract class CurrentDeviceBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CurrentDeviceBlocState_init extends CurrentDeviceBlocState {}

class CurrentDeviceBlocState_loading extends CurrentDeviceBlocState {}

class CurrentDeviceBlocState_loaded extends CurrentDeviceBlocState {
  final DeviceInfoModel deviceInfo;
  CurrentDeviceBlocState_loaded({required this.deviceInfo});

  @override
  List<Object?> get props => [deviceInfo];
}

class CurrentDeviceBlocState_error extends CurrentDeviceBlocState {}

class CurrentDeviceBloc
    extends Bloc<CurrentDeviceBlocEvent, CurrentDeviceBlocState> {
  final DeviceInfoRepositoryImpl deviceInfoRepo;
  CurrentDeviceBloc({required this.deviceInfoRepo})
    : super(CurrentDeviceBlocState_init()) {
    ///
    /// LOAD
    ///
    on<CurrentDeviceBlocEvent_load>((event, emit) async {
      final currentDevice = await deviceInfoRepo.getAndroidInfo();

      logger.i('Ge Current Device ${currentDevice.name}');
      emit(CurrentDeviceBlocState_loaded(deviceInfo: currentDevice));
    });
  }
}
