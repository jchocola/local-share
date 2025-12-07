import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/core/utils/date_format.dart';
import 'package:local_share/core/utils/format_file_size.dart';
import 'package:local_share/data/repo/embbeded_server.dart';

class ReceivedFileCard extends StatelessWidget {
  const ReceivedFileCard({super.key, required this.file , this.onPressed});
  final ReceivedFile file;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        title: Text(file.name, style: theme.textTheme.bodyMedium),
        subtitle: Text(
          '${formatFileSize(file.size)}     ${formatDateTime(file.receivedAt)}',
          style: theme.textTheme.bodySmall,
        ),

        trailing: IconButton(onPressed: onPressed, icon: Icon(AppIcon.receiveIcon)),
      ),
    );
  }
}
