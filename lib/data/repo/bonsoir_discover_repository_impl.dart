import 'package:bonsoir/bonsoir.dart';
import 'package:local_share/data/repo/network_repository_impl.dart';
import 'package:local_share/di/DI.dart';
import 'package:local_share/main.dart';

class BonsoirDiscoverRepositoryImpl {
  static final String _type = '_localshare._tcp';

  late BonsoirDiscovery discovery;
  final NetworkRepositoryImpl _networkRepositoryImpl = getIt<NetworkRepositoryImpl>();
  String? _localIP;

  Future<void> discoveryInitialize() async {
    discovery = BonsoirDiscovery(type: _type);
    await discovery.initialize();
    logger.i('Bonsoir discovery Initialized');
    
    // Get local IP to filter out self-discovery
    _localIP = await _networkRepositoryImpl.getLocalIPAddress();
    logger.i('Local IP for filtering: $_localIP');
  }

  Future<void> startDiscovery() async {
    await discovery.start();

    logger.i('Bonsoir discovery started');
  }

  Future<void> stopDiscovery() async {
    await discovery.stop();
    logger.i('Bonsoir discovery stopped');
  }
  
  /// Check if a discovered service is the local device
  bool isSelfDiscovery(BonsoirService service) {
    if (_localIP == null) return false;
    return service.host == _localIP;
  }

  ///
  /// SINGLETON
  ///
  BonsoirDiscoverRepositoryImpl._contructor();
  static final BonsoirDiscoverRepositoryImpl _instance =
      BonsoirDiscoverRepositoryImpl._contructor();

  static BonsoirDiscoverRepositoryImpl get instance => _instance;
}