import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';

class ReceivedFileWidget extends StatelessWidget {
  const ReceivedFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical:  AppConstant.appPadding/2 , horizontal: AppConstant.appPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.appBorder),
        color: theme.colorScheme.primary.withOpacity(0.2)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Received files (3)'),
          TextButton(onPressed: () {}, child: Text('Show')),
        ],
      ),
    );
  }
}
