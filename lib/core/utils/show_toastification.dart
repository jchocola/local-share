import 'package:flutter/cupertino.dart';
import 'package:toastification/toastification.dart';

void showErrorToatification(BuildContext context , {String title = 'Title' , String desc = 'Description'}) {
  toastification.show(
    context: context,
    type: ToastificationType.error,
    title: Text(title),
    description: Text(desc),
    autoCloseDuration: Duration(seconds: 3),
  );
}


void showSuccessToatification(BuildContext context , {String title = 'Title' , String desc = 'Description'}) {
  toastification.show(
    context: context,
    type: ToastificationType.success,
    title: Text(title),
    description: Text(desc),
     autoCloseDuration: Duration(seconds: 3),
  );
}

void showInfoToatification(BuildContext context , {String title = 'Title' , String desc = 'Description'}) {
  toastification.show(
    context: context,
    type: ToastificationType.info,
    title: Text(title),
    description: Text(desc),
     autoCloseDuration: Duration(seconds: 3),
  );
}

void showWarningToatification(BuildContext context , {String title = 'Title' , String desc = 'Description'}) {
  toastification.show(
    context: context,
    type: ToastificationType.warning,
    title: Text(title),
    description: Text(desc),
     autoCloseDuration: Duration(seconds: 3),
  );
}


