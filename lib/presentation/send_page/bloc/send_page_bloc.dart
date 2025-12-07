import 'package:bonsoir/bonsoir.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/data/repo/bonsoir_discover_repository_impl.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main.dart';

///
/// EVENT
///
abstract class SendPageBlocEvent {}

class SendPageBlocEvent_startBonsoirDiscover extends SendPageBlocEvent {}

///
/// STATE
///
abstract class SendPageBlocState {}

class SendPageBlocState_init extends SendPageBlocState {}

class SendPageBlocState_discovering extends SendPageBlocState {}

class SendPageBlocState_BonsoirDiscoveryStartedEvent
    extends SendPageBlocState {}

class SendPageBlocState_BonsoirDiscoveryServiceFoundEvent
    extends SendPageBlocState {
  final BonsoirService bonsoirService;

  SendPageBlocState_BonsoirDiscoveryServiceFoundEvent({required this.bonsoirService});
}

///
/// BLOC
///
class SendPageBloc extends Bloc<SendPageBlocEvent, SendPageBlocState> {
  final BonsoirDiscoverRepositoryImpl bonsoirDiscoverRepositoryImpl =
      getIt<BonsoirDiscoverRepositoryImpl>();

  SendPageBloc() : super(SendPageBlocState_init()) {
    ///
    /// ON START BONSOIR DISCOVER
    ///
    on<SendPageBlocEvent_startBonsoirDiscover>((event, emit) async {
      await bonsoirDiscoverRepositoryImpl.discoveryInitialize();
      await bonsoirDiscoverRepositoryImpl.startDiscovery();

      emit(SendPageBlocState_discovering());

      ///
      ///LISTEN EVENT
      ///
      bonsoirDiscoverRepositoryImpl.discovery.eventStream!.listen((event) async{
        switch (event) {
          case BonsoirDiscoveryStartedEvent():
            logger.e(
              'Service Started : port ${event.service?.port} , name ${event.service?.name}',
            );
            emit(SendPageBlocState_BonsoirDiscoveryStartedEvent());
            emit(SendPageBlocState_discovering());
            break;
          case BonsoirDiscoveryServiceFoundEvent():
            final BonsoirService bonsoirService = event.service;
            logger.e('Service found : ${event.service.toJson()}');
            await event.service!.resolve(
              bonsoirDiscoverRepositoryImpl.discovery.serviceResolver,
            ); // Should be called when the user wants to connect to this service.
            emit(SendPageBlocState_BonsoirDiscoveryServiceFoundEvent(bonsoirService: bonsoirService));
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

      
    });
  }
}
