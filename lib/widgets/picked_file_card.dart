import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';

class PickedFileCard extends StatelessWidget {
  const PickedFileCard({super.key , this.withFixedWidth = false});
  final bool  withFixedWidth;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SizedBox(
      width: withFixedWidth ?size.width * 0.6: double.infinity ,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(AppConstant.appPadding),
          child: Row(
            spacing: AppConstant.appPadding,
            children: [
              Icon(AppIcon.documentIcon, color: theme.colorScheme.primary),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FileName.text', style: theme.textTheme.titleSmall),
                  Text('34 MB', style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
