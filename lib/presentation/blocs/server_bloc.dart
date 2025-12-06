import 'dart:io'; // Add this import
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/embbeded_server.dart';
import 'package:local_share/main.dart';

///
/// EVENT
///
abstract class ServerBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerBlocEvent_openServer extends ServerBlocEvent {
  final List<File> files; // Add files parameter
  
  ServerBlocEvent_openServer({required this.files});
  
  @override
  List<Object?> get props => [files];
}

class ServerBlocEvent_closeServer extends ServerBlocEvent {}

class ServerBlocState_changeSwitcherValue extends ServerBlocEvent {
  final String value;
  ServerBlocState_changeSwitcherValue({required this.value});

  @override
  List<Object?> get props => [value];
}

///
/// STATE
///
abstract class ServerBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ServerBlocState_waiting extends ServerBlocState {}

class ServerBlocState_loadding extends ServerBlocState {}

class ServerBlocState_opened extends ServerBlocState {
  final String switcherValue;
  ServerBlocState_opened({required this.switcherValue});

  @override
  List<Object?> get props => [switcherValue];

  ServerBlocState_opened copyWith({
    String? switcherValue,
  }) {
    return ServerBlocState_opened(
      switcherValue: switcherValue ?? this.switcherValue,
    );
  }
}

class ServerBlocState_error extends ServerBlocState {
  final APP_ERROR_SUCCESS error;
  ServerBlocState_error({required this.error});

  @override
  List<Object?> get props => [error];
}

class ServerBlocState_success extends ServerBlocState {
  final APP_ERROR_SUCCESS success;
  ServerBlocState_success({required this.success});

  @override
  List<Object?> get props => [success];
}

///
/// BLOC
///
class ServerBloc extends Bloc<ServerBlocEvent, ServerBlocState> {
  final EmbbededServerRepoImpl serverRepo;
  ServerBloc({required this.serverRepo}) : super(ServerBlocState_waiting()) {
    ///
    /// ON OPEN SERVER
    ///
    on<ServerBlocEvent_openServer>((event, emit) async {
      try {
        emit(ServerBlocState_loadding());
        
        logger.i('Starting server with ${event.files.length} files');
        for (var i = 0; i < event.files.length; i++) {
          logger.i('File $i: ${event.files[i].path}');
          
          // Validate file
          if (event.files[i].path.isEmpty) {
            logger.w('File $i has empty path');
            continue;
          }
          
          if (!event.files[i].existsSync()) {
            logger.w('File $i does not exist: ${event.files[i].path}');
            continue;
          }
        }
        
        // Set picked files in server repo
        serverRepo.setPickedFiles(event.files);
        
        // Запускаем сервер
        await serverRepo.start();

        emit(ServerBlocState_success(success: APP_ERROR_SUCCESS.OPENED_SERVER));
        emit(ServerBlocState_opened(switcherValue: AppConstant.SEND_KEY));
      } catch (e, stackTrace) {
        logger.e('Error starting server: $e');
        logger.e('Stack trace: $stackTrace');
        emit(ServerBlocState_error(error: e as APP_ERROR_SUCCESS));
        emit(ServerBlocState_waiting());
      }
    });

    ///
    /// ON CLOSE SERVER
    ///
    on<ServerBlocEvent_closeServer>((event, emit) async {
      try {
        emit(ServerBlocState_loadding());

        // close server
        await serverRepo.close();

        emit(ServerBlocState_success(success: APP_ERROR_SUCCESS.CLOSED_SERVER));

        emit(ServerBlocState_waiting());
      } catch (e) {}
    });



    ///
    /// CHANGE SWITHCER VALUE
    ///
    on<ServerBlocState_changeSwitcherValue>((event, emit) {
      final currentState = state;

      if (currentState is ServerBlocState_opened) {
        logger.i('Changed swithcer ${event.value}');
        emit(currentState.copyWith(switcherValue: event.value));
      }
    });
  }
}
