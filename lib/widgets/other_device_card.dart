import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';

class OtherDeviceCard extends StatelessWidget {
  const OtherDeviceCard({super.key , this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(),
      title: Text('Device name', style: theme.textTheme.titleMedium,),
      subtitle: Text('ready to receive' , style: theme.textTheme.bodySmall,),
      trailing: Icon(AppIcon.arrowForwardIcon, size: AppConstant.smallIcon,),
    );
  }
}
