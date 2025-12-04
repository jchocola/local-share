import 'package:bonsoir/bonsoir.dart';
import 'package:local_share/main.dart';

class BonsoirBroadcastRepositoryImpl {
  static final BonsoirService _service = BonsoirService(
    name: 'LocalShare Service',
    type: '_localshare-service._tcp',
    port: 3030,
  );

  static final BonsoirBroadcast _broadcast = BonsoirBroadcast(
    service: _service,
  );

  Future<void> broadcastInitialize() async {
    await _broadcast.initialize();

    logger.i('Broadcast Initialized');
  }

  Future<void> broadcastStart() async {
    await _broadcast.start();
    logger.i('Broadcast Started');
  }

  Future<void> broadcastStop() async {
    await _broadcast.stop();
      logger.i('Broadcast Stopped');
  }

  ///
  /// SINGLETON
  ///
  BonsoirBroadcastRepositoryImpl._contructor();
  static final BonsoirBroadcastRepositoryImpl _instance =
      BonsoirBroadcastRepositoryImpl._contructor();

  static BonsoirBroadcastRepositoryImpl get instance => _instance;
}
