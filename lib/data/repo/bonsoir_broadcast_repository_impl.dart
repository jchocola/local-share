import 'package:bonsoir/bonsoir.dart';
import 'package:get_it/get_it.dart';
import 'package:local_share/data/repo/device_info_repository_impl.dart';
import 'package:local_share/data/repo/network_repository_impl.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main.dart';

class BonsoirBroadcastRepositoryImpl {
  final NetworkRepositoryImpl _networkRepositoryImpl =
      getIt<NetworkRepositoryImpl>();

  final DeviceInfoRepositoryImpl _deviceInfoRepositoryImpl =
      getIt<DeviceInfoRepositoryImpl>();

  ///
  /// Service running or not
  ///
  bool _isRunning = false;
  bool get isRunning => _isRunning;

  ///
  /// Service
  ///
  late BonsoirService _service;
  BonsoirService get service => _service;

  ///
  ///Broadcast
  ///
  late BonsoirBroadcast _broadcast;

  Future<void> broadcastInitialize({int port = 3030}) async {
    final localIP = await _networkRepositoryImpl.getLocalIPAddress();
    final deviceInfo = await _deviceInfoRepositoryImpl.getAndroidInfo();

    _service = BonsoirService(
      name: 'LocalShare Service',
      type: '_localshare._tcp',
      port: port,
      host: localIP,
      attributes: deviceInfo.toMap(),
    );

    _broadcast = BonsoirBroadcast(service: _service);

    await _broadcast.initialize();

    logger.i('Broadcast Initialized');
  }

  Future<void> broadcastStart() async {
    await _broadcast.start();
    _isRunning = true;
    logger.i('Broadcast Started');
  }

  Future<void> broadcastStop() async {
    _isRunning = false;
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