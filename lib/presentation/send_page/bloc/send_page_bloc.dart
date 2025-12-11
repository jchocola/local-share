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
  
  SendPageBlocEvent_sendFiles({required this.files});
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
  
  SendPageBlocState_sending({
    required this.totalFiles,
    required this.sentFiles,
    required this.progress,
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
  final BonsoirDiscoverRepositoryImpl bonsoirDiscoverRepositoryImpl =
      getIt<BonsoirDiscoverRepositoryImpl>();
      
  ServerClient? serverClient;
  StreamSubscription? _discoverySubscription;

  SendPageBloc() : super(SendPageBlocState_init()) {
    ///
    /// ON START BONSOIR DISCOVER
    ///
    on<SendPageBlocEvent_startBonsoirDiscover>((event, emit) async {
      await _startDiscovery(emit);
    });
    
    ///
    /// ON RESTART DISCOVERY
    ///
    on<SendPageBlocEvent_restartDiscovery>((event, emit) async {
      // Cancel existing subscription if any
      await _discoverySubscription?.cancel();
      
      // Restart discovery
      await _startDiscovery(emit);
    });
    
    ///
    /// ON CONNECT TO DEVICE
    ///
    on<SendPageBlocEvent_connectToDevice>((event, emit) async {
      try {
        emit(SendPageBlocState_connecting(service: event.service));
        
        // Initialize server client
        serverClient = ServerClient();
        
        // Connect to the device
        await serverClient!.connect(
          host: event.service.host!,
          port: event.service.port!,
        );
        
        emit(SendPageBlocState_connected(service: event.service));
      } catch (e) {
        logger.e('Error connecting to device: $e');
        emit(
          SendPageBlocState_error(message: 'Failed to connect to device: $e'),
        );
        emit(SendPageBlocState_discovering());
      }
    });
    
    ///
    /// ON SEND FILES
    ///
    on<SendPageBlocEvent_sendFiles>((event, emit) async {
      if (serverClient?.socket == null) {
        emit(SendPageBlocState_error(message: 'Not connected to any device'));
        return;
      }
      
      try {
        final totalFiles = event.files.length;
        int sentFiles = 0;
        
        for (final file in event.files) {
          // Update progress state
          emit(
            SendPageBlocState_sending(
              totalFiles: totalFiles,
              sentFiles: sentFiles,
              progress: sentFiles / totalFiles,
            ),
          );
          
          // Create file sender
          final fileSender = FileSender(serverClient!.socket, file: file);
          
          // Send file
          await fileSender.sendSingleFileWithoutAck();
          
          sentFiles++;
        }
        
        // Update final state
        emit(
          SendPageBlocState_sending(
            totalFiles: totalFiles,
            sentFiles: sentFiles,
            progress: 1.0,
          ),
        );
        
        emit(SendPageBlocState_sent());
      } catch (e) {
        logger.e('Error sending files: $e');
        emit(SendPageBlocState_error(message: 'Failed to send files: $e'));
      }
    });
  }
  
  Future<void> _startDiscovery(Emitter<SendPageBlocState> emit) async {
    try {
      await bonsoirDiscoverRepositoryImpl.discoveryInitialize();
      await bonsoirDiscoverRepositoryImpl.startDiscovery();

      emit(SendPageBlocState_discovering());

      ///
      /// LISTEN EVENT
      ///
      _discoverySubscription?.cancel();
      _discoverySubscription = bonsoirDiscoverRepositoryImpl.discovery.eventStream!.listen((
        event,
      ) async {
        switch (event) {
          case BonsoirDiscoveryStartedEvent():
            logger.e(
              'Service Started : port ${event.service?.port} , name ${event.service?.name}',
            );
            add(SendPageBlocEvent_startBonsoirDiscover());
            break;
          case BonsoirDiscoveryServiceFoundEvent():
            final BonsoirService bonsoirService = event.service;
            logger.e('Service found : ${event.service.toJson()}');
            await event.service!.resolve(
              bonsoirDiscoverRepositoryImpl.discovery.serviceResolver,
            ); // Should be called when the user wants to connect to this service.
            emit(
              SendPageBlocState_BonsoirDiscoveryServiceFoundEvent(
                bonsoirService: bonsoirService,
              ),
            );
            emit(SendPageBlocState_discovering());
            break;
          case BonsoirDiscoveryServiceResolvedEvent():
            logger.e('Service resolved : ${event.service.toJson()}');
            break;
          case BonsoirDiscoveryServiceUpdatedEvent():
            logger.e('Service updated : ${event.service.toJson()}');
            break;
          case BonsoirDiscoveryServiceLostEvent():
            logger.e('Service lost : ${event.service.toJson()}');
            break;
          default:
            logger.e('Another event occurred : $event.');
            break;
        }
      });
    } catch (e) {
      logger.e('Error starting discovery: $e');
      emit(SendPageBlocState_error(message: 'Failed to start discovery: $e'));
    }
  }
  
  @override
  Future<void> close() {
    _discoverySubscription?.cancel();
    return super.close();
  }
}