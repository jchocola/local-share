// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:local_share/core/constant/app_constant.dart';
// import 'package:local_share/main.dart';

// ///
// /// EVENT
// ///
// abstract class ServerPageBlocEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ServerPageBlocState_load extends ServerPageBlocEvent {}

// class ServerPageBlocState_changeSwitcherValue extends ServerPageBlocEvent {
//   final String value;
//   ServerPageBlocState_changeSwitcherValue({required this.value});

//   @override
//   List<Object?> get props => [value];
// }

// ///
// /// STATE
// ///
// abstract class ServerPageBlocState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ServerPageBlocState_init extends ServerPageBlocState {}

// class ServerPageBlocState_loading extends ServerPageBlocState {}

// class ServerPageBlocState_loaded extends ServerPageBlocState {
//   final String switcherValue;
//   ServerPageBlocState_loaded({required this.switcherValue});
//   @override
//   List<Object?> get props => [switcherValue];

//   ServerPageBlocState_loaded copyWith({String? switcherValue}) {
//     return ServerPageBlocState_loaded(
//       switcherValue: switcherValue ?? this.switcherValue,
//     );
//   }
// }

// class ServerPageBlocState_error extends ServerPageBlocState {}

// ///
// ///BLOC
// ///
//  class ServerPageBloc
//     extends Bloc<ServerPageBlocEvent, ServerPageBlocState> {
//   ServerPageBloc() : super(ServerPageBlocState_init()) {
//     ///
//     /// ON LOAD
//     ///
//     on<ServerPageBlocState_load>((event, emit) {
//       emit(ServerPageBlocState_loaded(switcherValue: AppConstant.SEND_KEY));
//     });

//     ///
//     /// CHANGE SWITHCER VALUE
//     ///
//     on<ServerPageBlocState_changeSwitcherValue>((event, emit) {
//       final currentState = state;

//       if (currentState is ServerPageBlocState_loaded) {
//         logger.i('Changed swithcer ${event.value}');
//         emit(currentState.copyWith(switcherValue: event.value));
//       }
//     });
//   }
// }
