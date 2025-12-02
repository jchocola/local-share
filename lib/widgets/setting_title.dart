import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({
    super.key,
    this.icon = Icons.add,
    this.title = 'Title',
    this.subtitle = 'Subtitle',
    this.trailingWidget

  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Widget ?trailingWidget;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Icon(icon, color: theme.colorScheme.primary),
      title: Text(title, style: theme.textTheme.titleSmall),
      subtitle: Text(subtitle, style: theme.textTheme.bodySmall),
      trailing: trailingWidget,
    );
  }
}
