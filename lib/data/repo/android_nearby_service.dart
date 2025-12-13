import 'package:local_share/main.dart';
import 'package:nearby_service/nearby_service.dart';

class AndroidNearbyService {
  final _nearbyService = NearbyService.getInstance().android;

  Future<void> init() async {
    await _nearbyService?.initialize();
    logger.i('Android nearby service inited');
  }

  Future<bool?> checkPermission() async {
    final granted = await _nearbyService?.requestPermissions();
    return granted;
  }

  Future<bool?> isWifiEnabled() async {
    final isWifiEnabled = await _nearbyService?.checkWifiService();
    return isWifiEnabled;
  }

  Future<void> startDiscover() async {
    final result = await _nearbyService!.discover();
    if (result) {
      // go to the listening peers step
    }
  }
}
