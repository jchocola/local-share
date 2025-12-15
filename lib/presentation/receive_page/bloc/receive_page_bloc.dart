// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/data/repo/bonsoir_broadcast_repository_impl.dart';
import 'package:local_share/data/repo/embedded_socket.dart';
import 'package:local_share/data/repo/file_receiver.dart';
import 'package:local_share/main.dart';
import 'package:local_share/presentation/server_page/widget/received_file_card.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

///
/// EVENT
///
abstract class ReceivePageBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecievePageBlocEvent_ChangeVisiblity extends ReceivePageBlocEvent {}

///
/// STATE
///

abstract class ReceivePageBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ReceivePageBlocState_initial extends ReceivePageBlocState {}

class ReceivePageBlocState_loading extends ReceivePageBlocState {}

class ReceivePageBlocState_unvisible extends ReceivePageBlocState {}

class ReceivePageBlocState_visible extends ReceivePageBlocState {}

class ReceivePageBlocState_error extends ReceivePageBlocState {
  final APP_EXCEPTION error;
  ReceivePageBlocState_error({required this.error});
}

///
/// BLOC
///
class ReceivePageBloc extends Bloc<ReceivePageBlocEvent, ReceivePageBlocState> {
  ReceivePageBloc() : super(ReceivePageBlocState_unvisible()) {
    ///
    /// CHANGE VISIBILITY
    ///
    on<RecievePageBlocEvent_ChangeVisiblity>((event, emit) async {
      final currentState = state;
      logger.i('Changed visibility');
      if (currentState is ReceivePageBlocState_unvisible) {
        emit(ReceivePageBlocState_visible());
      }

      if (currentState is ReceivePageBlocState_visible) {
        emit(ReceivePageBlocState_unvisible());
      }
    });
  }
}
