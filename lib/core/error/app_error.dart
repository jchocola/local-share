enum APP_ERROR_SUCCESS {
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
}

String AppErrorConverter({required APP_ERROR_SUCCESS error}) {
  switch (error) {


    ///
    /// ERRORS
    ///
    case APP_ERROR_SUCCESS.NOT_CONNECTED_WIFI:
      return 'Not Wi-fi connected';

     case APP_ERROR_SUCCESS.NOT_WIFI_NEARBY_SERVICE_GRANTED:
      return 'Not Wi-fi connected';


    ///
    ///  SUCCESSES
    ///
    case APP_ERROR_SUCCESS.OPENED_SERVER:
      return 'Opened server';
     
     case APP_ERROR_SUCCESS.CLOSED_SERVER:
      return 'Closed server';  
  }
}
