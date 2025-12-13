import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/main.dart';
import 'package:nearby_service/nearby_service.dart';

class AndroidNearbyService {
  final _nearbyService = NearbyService.getInstance().android;

  Future<void> init() async {
    final isWifiConnected = await isWifiEnabled();

    if (isWifiConnected == null || isWifiConnected == false) {
      throw APP_ERROR_SUCCESS.NOT_CONNECTED_WIFI;
    }

    final granted = await checkPermission();

    if (granted == null || granted == false) {
      throw APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED;
    }

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
    await _nearbyService!.discover();
    logger.i('Nearby discover started');
  }

  Future<void> stopDiscover() async {
    await _nearbyService!.stopDiscovery();
     logger.i('Nearby discover stopped');
  }

  Future<NearbyDeviceInfo?> getCurrentDeviceInfo() async {
    return await _nearbyService!.getCurrentDeviceInfo();
  }
}
