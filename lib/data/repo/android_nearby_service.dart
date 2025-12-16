import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/main.dart';
import 'package:nearby_service/nearby_service.dart';
import 'package:permission_handler/permission_handler.dart';

class AndroidNearbyService {
  final nearbyService = NearbyService.getInstance();

  Future<void> init() async {
    await nearbyService.initialize();
    logger.i('Android nearby service inited');

    final isWifiConnected = await isWifiEnabled();

    if (isWifiConnected == null || isWifiConnected == false) {
      throw APP_EXCEPTION.NOT_CONNECTED_WIFI;
    }

    final granted = await checkPermission();

    if (granted == null || granted == false) {
      throw APP_EXCEPTION.NOT_WIFI_NEARBY_SERVICE_GRANTED;
    }
  }

  Future<bool?> checkPermission() async {
    final granted = await nearbyService.android!.requestPermissions();
    return granted;
  }

  Future<bool?> isWifiEnabled() async {
    final isWifiEnabled = await nearbyService.android!.checkWifiService();
    return isWifiEnabled;
  }

  Future<void> startDiscover() async {
    await nearbyService.discover();
    logger.i('Nearby discover started');
  }

  Future<void> stopDiscover() async {
    await nearbyService.stopDiscovery();
    logger.i('Nearby discover stopped');
  }

  Future<void> openAppSetting() async {
    openAppSettings();
  }

  Future<void> openNetworkSetting() async {
    await nearbyService.openServicesSettings();
  }

  Future<NearbyDeviceInfo?> getCurrentDeviceInfo() async {
    return await nearbyService.getCurrentDeviceInfo();
  }

  Future<void> connectDevice({required NearbyDevice device}) async {
    try {
      await nearbyService.connectById(device.info.id);
    } catch (e) {
      logger.e('failed to connect device');
    }
  }

  Future<String?> sendFileRequest({
    required List<NearbyFileInfo> files,
    required NearbyDeviceInfo receiver,
  }) async {
    try {
      final request = NearbyMessageFilesRequest.create(files: files);
      await nearbyService.send(
        OutgoingNearbyMessage(
          content: request,
          receiver: receiver,
        ),
      );
      return request.id;
    } catch (e) {
      logger.e(e.toString());
      return null;
    }
  }

  Future<void> sendFileResponse({
    required String requestId,
    required bool isAccepted,
    required NearbyDeviceInfo receiver,
  }) async {
    try {
      await nearbyService.send(
        OutgoingNearbyMessage(
          content: NearbyMessageFilesResponse(
            id: requestId,
            isAccepted: isAccepted,
          ),
          receiver: receiver,
        ),
      );
    } catch (e) {
      logger.e(e.toString());
    }
  }

}
