import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/data/repo/embbeded_server.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/profile_info_widget.dart';
import 'package:local_share/presentation/server_page/widget/received_file_card.dart';
import 'package:local_share/widgets/big_button.dart';


class IncomingTransferWidget extends StatelessWidget {
  const IncomingTransferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Incoming Transfer', style: theme.textTheme.titleLarge),
            ProfileInfoWidget(),
            incomingFiles(context),
            //FilesToSendWidget(),
            Divider(),
            Row(
              spacing: AppConstant.appPadding,
              children: [
                Expanded(
                  flex: 1,
                  child: BigButton(
                    title: 'Decline',
                    color: theme.scaffoldBackgroundColor,
                    textColor: theme.colorScheme.onSecondary,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: BigButton(
                    title: 'Accept',
                    color: theme.colorScheme.secondary,
                    withIcon: true,
                    icon: AppIcon.receiveIcon,
                    onTap: () {
                      context.push('/receive_page/transfer_progress');
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget incomingFiles(context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('4 Files'),
              Text('133 MB')
            ],
          ),
          ReceivedFileCard(file: ReceivedFile(name: 'Hello', path: 'ds', size: 132, receivedAt: DateTime.now()))

        ],
      ),
    );
  }
}
