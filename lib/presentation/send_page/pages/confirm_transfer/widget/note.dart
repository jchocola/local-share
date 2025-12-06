import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';

class NoteWidget2 extends StatelessWidget {
  const NoteWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConstant.appPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.appPadding),
        color: theme.colorScheme.onSecondary.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Transfer Info', style: theme.textTheme.bodyMedium),
          Text(
            '- Files will be transferred over local network',
            style: theme.textTheme.bodySmall,
          ),
          Text(
            '- No internet connection required',
            style: theme.textTheme.bodySmall,
          ),
          Text(
            '- Transfer speed depends on network quality',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
