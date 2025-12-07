import 'package:get_it/get_it.dart';
import 'package:local_share/data/repo/bonsoir_broadcast_repository_impl.dart';
import 'package:local_share/data/repo/bonsoir_discover_repository_impl.dart';
import 'package:local_share/data/repo/device_info_repository_impl.dart';
import 'package:local_share/data/repo/embbeded_server.dart';
import 'package:local_share/data/repo/network_repository_impl.dart';
import 'package:local_share/data/repo/shared_prefs_repository_impl.dart';
import 'package:local_share/main.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<SharedPrefsRepositoryImpl>(
    SharedPrefsRepositoryImpl.instance,
  );

  getIt.registerSingleton<DeviceInfoRepositoryImpl>(DeviceInfoRepositoryImpl());

  getIt.registerSingleton<EmbbededServerRepoImpl>(
    EmbbededServerRepoImpl.instance,
  );
   getIt.registerSingleton<NetworkRepositoryImpl>(
    NetworkRepositoryImpl.instance,
  );

  getIt.registerSingleton<BonsoirBroadcastRepositoryImpl>(
    BonsoirBroadcastRepositoryImpl.instance,
  );

  getIt.registerSingleton<BonsoirDiscoverRepositoryImpl>(
    BonsoirDiscoverRepositoryImpl.instance,
  );

 

  logger.i('DI inited');
}
