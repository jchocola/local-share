import 'package:device_info_plus/device_info_plus.dart';
import 'package:local_share/data/model/device_info_model.dart';
import 'package:local_share/data/repo/shared_prefs_repository_impl.dart';
import 'package:local_share/main.dart';

class DeviceInfoRepositoryImpl {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final SharedPrefsRepositoryImpl _sharedPrefs = SharedPrefsRepositoryImpl.instance;

  Future<DeviceInfoModel> getAndroidInfo() async {
    final AndroidDeviceInfo androidDeviceInfo = await _deviceInfo.androidInfo;
    final deviceID = await _sharedPrefs.getDeviceID();

    logger.i(androidDeviceInfo.device);
    logger.i(androidDeviceInfo.brand);
    logger.i(deviceID);

    return DeviceInfoModel(
      name: androidDeviceInfo.device + androidDeviceInfo.brand,
      deviceId: deviceID
    );
  }


}
