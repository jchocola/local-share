import 'package:local_share/main.dart';
import 'package:network_info_plus/network_info_plus.dart';

class NetworkRepositoryImpl {
  Future<String?> getLocalIPAddress() async {
    final NetworkInfo networkInfo = NetworkInfo();
    final ip = await networkInfo.getWifiIP();
    logger.i('Current Local IP : ${ip}');
    return ip;
  }

  ///
  /// Singleton
  ///
  NetworkRepositoryImpl._();
  static final NetworkRepositoryImpl _instance = NetworkRepositoryImpl._();
  static NetworkRepositoryImpl get instance => _instance;
}
