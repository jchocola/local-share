enum APP_ERROR { NOT_CONNECTED_WIFI }

String AppErrorConverter({required APP_ERROR error}) {
  switch (error) {
    case APP_ERROR.NOT_CONNECTED_WIFI:
      return 'Not Wi-fi connected';
  }
}
