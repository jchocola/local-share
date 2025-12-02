// ignore_for_file: camel_case_types

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/main.dart';

///
/// EVENT
///
abstract class SendPageBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendPageBlocEvent_ChangeVisiblity extends SendPageBlocEvent {}

///
/// STATE
///

abstract class SendPageBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendPageBlocState_initial extends SendPageBlocState {}

class SendPageBlocState_loading extends SendPageBlocState {}

class SendPageBlocState_loaded extends SendPageBlocState {
  final bool visible;
  SendPageBlocState_loaded({required this.visible});

  @override
  List<Object?> get props => [visible];

  SendPageBlocState_loaded copyWith({bool? visible}) {
    return SendPageBlocState_loaded(visible: visible ?? this.visible);
  }
}

class SendPageBlocState_error extends SendPageBlocState {}

///
/// BLOC
///
class SendPageBloc extends Bloc<SendPageBlocEvent, SendPageBlocState> {
  SendPageBloc() : super(SendPageBlocState_loaded(visible: true)) {
    ///
    /// CHANGE VISIBILITY
    ///
    on<SendPageBlocEvent_ChangeVisiblity>((event, emit) {
      final currentState = state;

      logger.i('Changed visiblity');
      
      if (currentState is SendPageBlocState_loaded) {
        emit(currentState.copyWith(visible: !currentState.visible));
      }
    });
  }
}
