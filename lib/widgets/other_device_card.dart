import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:nearby_service/nearby_service.dart';

class OtherDeviceCard extends StatelessWidget {
  const OtherDeviceCard({super.key, this.onTap , this.device});
  final void Function()? onTap;
  final NearbyDevice? device;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: CustomAvatar(name: device?.info.displayName ?? '',),
      title: Text( device?.info.displayName ?? 'Unknown', style: theme.textTheme.titleMedium),
      subtitle: Text(device?.info.id ?? '', style: theme.textTheme.bodySmall),
      trailing: Icon(AppIcon.arrowForwardIcon, size: AppConstant.smallIcon),
    );
  }
}
