import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/receive_page/pages/transfer_progress_page/widget/file_looading_card.dart';

class FilesTransferProgress extends StatelessWidget {
  const FilesTransferProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Files (3)'),
            FileLooadingCard(isDone: false,),
            FileLooadingCard(),
            FileLooadingCard(),
          ],
        ),
      ),
    );
  }
}
