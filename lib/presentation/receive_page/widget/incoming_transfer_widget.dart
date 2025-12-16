import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nearby_service/nearby_service.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/data/repo/embbeded_server.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/profile_info_widget.dart';
import 'package:local_share/presentation/server_page/widget/received_file_card.dart';
import 'package:local_share/widgets/big_button.dart';

class IncomingTransferWidget extends StatelessWidget {
  final NearbyMessageFilesRequest? request;

  const IncomingTransferWidget({super.key, this.request});

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
                    onTap: () {
                      if (request != null) {
                        // dispatch decline event
                        // use bloc from context
                        // ignore: use_build_context_synchronously
                        final bloc = context.read<SendReceiveBloc>();
                        bloc.add(SendReceiveBlocEvent_declineIncomingRequest(requestId: request!.id));
                      }
                      Navigator.of(context).pop();
                    },
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
                      if (request != null) {
                        final bloc = context.read<SendReceiveBloc>();
                        bloc.add(SendReceiveBlocEvent_acceptIncomingRequest(requestId: request!.id));
                      }
                      context.push('/receive_page/transfer_progress');
                      Navigator.of(context).pop();
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
    final theme = Theme.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('4 Files', style: theme.textTheme.bodyMedium),
              Text('133 MB', style: theme.textTheme.titleMedium),
            ],
          ),
          ReceivedFileCard(
            file: ReceivedFile(
              name: 'Hello',
              path: 'ds',
              size: 132,
              receivedAt: DateTime.now(),
            ),
          ),
        ],
      ),
    );
  }
}
