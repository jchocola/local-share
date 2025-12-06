import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    super.key,
    this.icon = Icons.info_outline,
    this.title = 'Note',
  });
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Row(
          spacing: AppConstant.appPadding,
          children: [
            Icon(icon),
            Flexible(child: Text(title, style: theme.textTheme.bodySmall)),
          ],
        ),
      ),
    );
  }
}
