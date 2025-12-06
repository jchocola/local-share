import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/data/repo/embbeded_server.dart';

///
/// EVENT
///
abstract class ServerBlocEvent {}

class ServerBlocEvent_openServer extends ServerBlocEvent {}

class ServerBlocEvent_closeServer extends ServerBlocEvent {}

///
/// STATE
///
abstract class ServerBlocState {}

class ServerBlocState_waiting extends ServerBlocState {}

class ServerBlocState_loadding extends ServerBlocState {}

class ServerBlocState_opened extends ServerBlocState {}

class ServerBlocState_error extends ServerBlocState {}

///
/// BLOC
///
class ServerBloc extends Bloc<ServerBlocEvent, ServerBlocState> {
  final EmbbededServer embbededServer;
  ServerBloc({required this.embbededServer})
    : super(ServerBlocState_waiting()) {
    ///
    /// ON OPEN SERVER
    ///
    on<ServerBlocEvent_openServer>((event, emit) async {
      emit(ServerBlocState_loadding());
      await Future.delayed(Duration(seconds: 2));
      emit(ServerBlocState_opened());
    });

    ///
    /// ON CLOSE SERVER
    ///
    on<ServerBlocEvent_closeServer>((event, emit) async{
       emit(ServerBlocState_loadding());
      await Future.delayed(Duration(seconds: 2));
      emit(ServerBlocState_waiting());
    });
  }
}
