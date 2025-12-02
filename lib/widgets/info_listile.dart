import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';

class InfoListile extends StatelessWidget {
  const InfoListile({super.key , this.title = 'title', this.icon = Icons.add , this.onTap});
  final String title;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleMedium),
      trailing: Icon(AppIcon.arrowForwardIcon, size: AppConstant.smallIcon),
    );
  }
}
