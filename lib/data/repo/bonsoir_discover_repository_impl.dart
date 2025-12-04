import 'package:bonsoir/bonsoir.dart';
import 'package:local_share/main.dart';

class BonsoirDiscoverRepositoryImpl {
  static final String _type = '_localshare-service._tcp';

  late BonsoirDiscovery discovery;

  Future<void> discoveryInitialize() async {
    discovery = BonsoirDiscovery(type: _type);
    await discovery.initialize();
    logger.i('Bonsoir discovery Initialized');

    discovery.eventStream!.listen((event) {
      switch (event) {
        case BonsoirDiscoveryStartedEvent():
            logger.e('Service Started : port ${event.service?.port} , name ${event.service?.name}');
          break; 
        case BonsoirDiscoveryServiceFoundEvent():
          logger.e('Service found : ${event.service.toJson()}');
          event.service!.resolve(
            discovery.serviceResolver,
          ); // Should be called when the user wants to connect to this service.
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
  }

  Future<void> startDiscovery() async {
    await discovery.start();
    logger.i('Bonsoir discovery started');
  }

  Future<void> stopDiscovery() async {
    await discovery.stop();
    logger.i('Bonsoir discovery stopped');
  }

  ///
  /// SINGLETON
  ///
  BonsoirDiscoverRepositoryImpl._contructor();
  static final BonsoirDiscoverRepositoryImpl _instance =
      BonsoirDiscoverRepositoryImpl._contructor();

  static BonsoirDiscoverRepositoryImpl get instance => _instance;
}
