import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nearby_service/nearby_service.dart';

///
/// EVENT
///
abstract class PickedNearbyDeviceBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedNearbyDeviceBlocEvent_pickDevice
    extends PickedNearbyDeviceBlocEvent {
  final NearbyDevice device;

  PickedNearbyDeviceBlocEvent_pickDevice({required this.device});
  @override
  List<Object?> get props => [device];
}


///
/// STATE
///
abstract class PickedNearbyDeviceBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PickedNearbyDeviceBlocState_init extends PickedNearbyDeviceBlocState {}

class PickedNearbyDeviceBlocState_picked extends PickedNearbyDeviceBlocState {
  final NearbyDevice device;
  PickedNearbyDeviceBlocState_picked({required this.device});

  @override
  List<Object?> get props => [device];
}

///
/// BLOC
///
class PickedNearbyDeviceBloc
    extends Bloc<PickedNearbyDeviceBlocEvent, PickedNearbyDeviceBlocState> {
  PickedNearbyDeviceBloc() : super(PickedNearbyDeviceBlocState_init()) {
    ///
    /// PICKED FILE
    ///
    on<PickedNearbyDeviceBlocEvent_pickDevice>((event, emit) {
      emit(PickedNearbyDeviceBlocState_picked(device: event.device));
    });
  }
}
