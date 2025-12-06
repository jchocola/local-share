import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';

class ReadyToReceiveCard extends StatelessWidget {
  const ReadyToReceiveCard({super.key, this.ready = true});
  final bool ready;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.appBorder),
        color: ready ? theme.colorScheme.secondary.withOpacity(0.2) : theme.colorScheme.error.withOpacity(0.2) 
      ),
      padding: EdgeInsets.symmetric(horizontal: AppConstant.appPadding , vertical: AppConstant.appPadding/2),
      child: Text(ready ? 'Ready to receive' : 'Not ready to receive', style: theme.textTheme.bodySmall!.copyWith(
         color: ready ? theme.colorScheme.secondary : theme.colorScheme.error
      ),),
    );
  }
}
