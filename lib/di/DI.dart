import 'package:get_it/get_it.dart';
import 'package:local_share/data/repo/shared_prefs_repository_impl.dart';
import 'package:local_share/main.dart';

final getIt = GetIt.instance;

Future<void> DI() async {
  getIt.registerSingleton<SharedPrefsRepositoryImpl>(
    SharedPrefsRepositoryImpl.instance,
  );

  logger.i('DI inited');
}
