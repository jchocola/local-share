import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/data/repo/bonsoir_discover_repository_impl.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main.dart';
import 'package:local_share/data/repo/server_client.dart';
import 'package:local_share/data/repo/file_sender.dart';
import 'dart:io';
import 'dart:async';

///
/// EVENT
///
abstract class SendPageBlocEvent {}

class SendPageBlocEvent_startBonsoirDiscover extends SendPageBlocEvent {}

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

class SendPageBlocState_BonsoirDiscoveryStartedEvent extends SendPageBlocState {}

class SendPageBlocState_BonsoirDiscoveryServiceFoundEvent extends SendPageBlocState {
  final BonsoirService bonsoirService;

  SendPageBlocState_BonsoirDiscoveryServiceFoundEvent({
    required this.bonsoirService,
  });
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
  final String message;
  
  SendPageBlocState_error({required this.message});
}

///
/// BLOC
///
class SendPageBloc extends Bloc<SendPageBlocEvent, SendPageBlocState> {


  SendPageBloc() : super(SendPageBlocState_init()) {
    ///
    /// ON START BONSOIR DISCOVER
    ///
    on<SendPageBlocEvent_startBonsoirDiscover>((event, emit) async {
     
    });
    
    ///
    /// ON RESTART DISCOVERY
    ///
    on<SendPageBlocEvent_restartDiscovery>((event, emit) async {
    
    });
    
    ///
    /// ON CONNECT TO DEVICE
    ///
    on<SendPageBlocEvent_connectToDevice>((event, emit) async {
      
      
    });
    
    ///
    /// ON SEND FILES
    ///
    on<SendPageBlocEvent_sendFiles>((event, emit) async {
    
     
    });
  }
  

  @override
  Future<void> close() {
  
    return super.close();
  }
}