import 'package:flutter/material.dart';
import 'package:local_share/generated/l10n.dart';

enum APP_EXCEPTION {
  ///
  /// ERRORS
  ///
  NOT_CONNECTED_WIFI,
  NOT_WIFI_NEARBY_SERVICE_GRANTED,

  ///
  /// SUCCESSES
  ///
  OPENED_SERVER,
  CLOSED_SERVER,
  NEARBY_SERVICE_DISCOVERING,
  NEARBY_SERVICE_STOPPED,
  FOUNDED_DEVICE,

}

String AppErrorConverter(BuildContext context, {required APP_EXCEPTION error}) {
  switch (error) {
    ///
    /// ERRORS
    ///
    case APP_EXCEPTION.NOT_CONNECTED_WIFI:
      return S.of(context).wifiNotConnected;

    case APP_EXCEPTION.NOT_WIFI_NEARBY_SERVICE_GRANTED:
      return 'Nearby service is denied';

    ///
    ///  SUCCESSES
    ///
    case APP_EXCEPTION.OPENED_SERVER:
      return S.of(context).openedServer;

    case APP_EXCEPTION.CLOSED_SERVER:
      return S.of(context).closedServer;

    case APP_EXCEPTION.NEARBY_SERVICE_STOPPED:
      return 'Neaby Service stoped discover';  

    case APP_EXCEPTION.NEARBY_SERVICE_DISCOVERING:
      return 'Nearby Service discovering';
    case APP_EXCEPTION.FOUNDED_DEVICE:
      return 'fOUNDED DEVICE';
  }
}
