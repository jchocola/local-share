import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';

class Note extends StatelessWidget {
  const Note({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppConstant.appPadding,
          children: [
            Icon(AppIcon.infoIcon, size: AppConstant.smallIcon,),
            Expanded(
              child: Text(
                'Do not close this app or turn off your device during transfer.',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
