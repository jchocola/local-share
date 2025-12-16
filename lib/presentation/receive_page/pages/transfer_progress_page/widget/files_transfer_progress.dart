import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/receive_page/pages/transfer_progress_page/widget/file_looading_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';

class FilesTransferProgress extends StatelessWidget {
  const FilesTransferProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: BlocBuilder<SendReceiveBloc, SendReceiveBlocState>(
          builder: (context, state) {
            if (state is SendReceiveBloc_TransferProgress) {
              final total = state.totalFiles;
              final processed = state.processedFiles;
              final items = <Widget>[];
              for (int i = 0; i < total; i++) {
                final isDone = i < processed;
                final isCurrent = i == processed && processed < total;
                items.add(FileLooadingCard(isDone: isDone && !isCurrent));
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Files ($total)'),
                  SizedBox(height: 8),
                  ...items,
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Files'),
                FileLooadingCard(isDone: false),
              ],
            );
          },
        ),
      ),
    );
  }
}
