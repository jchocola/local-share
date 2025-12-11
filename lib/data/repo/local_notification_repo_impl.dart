import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:local_share/data/repo/permission_repo_impl.dart';
import 'package:local_share/main.dart';

class LocalNotificationRepoImpl {
  final PermissionRepoImpl _permissionRepo = PermissionRepoImpl.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_notification');
  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        'transfer_completed',
        'Transfer Completed',
        channelDescription: 'Notify users when files transfered completely.',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

  Future<void> init() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          macOS: initializationSettingsDarwin,
        );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    logger.e('Local Notificaion inited');
  }

  Future<void> showSimpleNotification({String title = 'Title' ,String body = 'Body'}) async {
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  // singleton
  LocalNotificationRepoImpl._();
  static final LocalNotificationRepoImpl _instance =
      LocalNotificationRepoImpl._();

  static LocalNotificationRepoImpl get instance => _instance;
}
