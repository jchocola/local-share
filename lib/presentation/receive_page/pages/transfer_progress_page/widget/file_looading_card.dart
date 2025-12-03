import 'package:flutter/material.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/custom_linear_progress_bar.dart';

class FileLooadingCard extends StatelessWidget {
  const FileLooadingCard({super.key , this.isDone = true});
  final bool isDone;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: isDone ? Icon(AppIcon.doneIcon , color: theme.colorScheme.secondary,) : Transform.scale(scale: 0.4, child: CircularProgressIndicator()),
      title: Text(
        'Vacation_Highlights_2025.mp4',
        style: theme.textTheme.titleSmall,
      ),
      subtitle: isDone ? Text('Completed', style: theme.textTheme.bodySmall,) : CustomLinearProgressBar(showPercentage: true,height: 10,),
    );
  }
}
