import 'package:permission_handler/permission_handler.dart';

class PermissionRepoImpl {
  Future<void> checkNotificationPermission() async {
    var status = await Permission.notification.status;

    if (status.isGranted) {
      return;
    } else {
      await Permission.notification.request();
    }
  }

  // singleton
  PermissionRepoImpl._();
  static final PermissionRepoImpl _instance = PermissionRepoImpl._();
  static PermissionRepoImpl get instance => _instance;
}
