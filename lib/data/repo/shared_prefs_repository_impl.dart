import 'package:local_share/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsRepositoryImpl {
  late SharedPreferences prefs;

  ///
  /// keys
  ///
  static const String OVERWRITE_EXISTING_FILE = 'OVERWRITE_EXSISTING_FILE';
  static const String AUTO_ACCEPT_SMALL_FILE = 'AUTO_ACCEPT_SMALL_FILE';
  static const String TRANSFER_NOTIFICATION = 'TRANSFER_NOTIFICATION';
  static const String DOWNLOAD_LOCATION = 'DOWNLOAD_LOCATION';

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    logger.i('Shared prefs inited');
  }

  bool getOverwriteExistingFile() {
    return prefs.getBool(OVERWRITE_EXISTING_FILE) ?? false;
  }

  Future<void> toogleOverwriteExistingFile() async {
    final currentValue = getOverwriteExistingFile();
    await prefs.setBool(OVERWRITE_EXISTING_FILE, !currentValue);
  }

  bool getAutoAcceptSmallFile() {
    return prefs.getBool(AUTO_ACCEPT_SMALL_FILE) ?? false;
  }

  Future<void> toogleAutoAcceptSmallFile() async {
    final currentValue = getAutoAcceptSmallFile();
    await prefs.setBool(AUTO_ACCEPT_SMALL_FILE, !currentValue);
  }

  bool getTransferNotification() {
    return prefs.getBool(TRANSFER_NOTIFICATION) ?? false;
  }

  Future<void> toogleTransferNotification() async {
    final currentValue = getTransferNotification();
    await prefs.setBool(TRANSFER_NOTIFICATION, !currentValue);
  }

  Future<String> getDownloadLocation() async {
    final location = prefs.getString(DOWNLOAD_LOCATION);

    if (location == null) {
      final dir = await getApplicationDocumentsDirectory();

      return dir.path;
    } else {
      return location;
    }
  }

  ///
  /// singleton
  ///
  SharedPrefsRepositoryImpl._();
  static final SharedPrefsRepositoryImpl _instance =
      SharedPrefsRepositoryImpl._();

  static SharedPrefsRepositoryImpl get instance => _instance;
}
