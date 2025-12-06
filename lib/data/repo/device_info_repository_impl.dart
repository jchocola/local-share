import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_share/data/model/device_info_model.dart';
import 'package:local_share/main.dart';

class DeviceInfoRepositoryImpl {
  DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<DeviceInfoModel> getAndroidInfo() async {
    final AndroidDeviceInfo androidDeviceInfo = await _deviceInfo.androidInfo;

    logger.i(androidDeviceInfo.device);
    logger.i(androidDeviceInfo.brand);

    return DeviceInfoModel(
      name: androidDeviceInfo.device + androidDeviceInfo.brand,
    );
  }
}
