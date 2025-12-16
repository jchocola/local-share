import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/receive_page/bloc/receive_page_bloc.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';
import 'package:local_share/presentation/receive_page/pages/transfer_progress_page/widget/transfer_complete_card.dart';
import 'package:local_share/presentation/receive_page/widget/incoming_transfer_widget.dart';
import 'package:local_share/presentation/receive_page/widget/waiting_annimation_widget.dart';
import 'package:local_share/presentation/send_page/widget/searching_animation_with_founded_list.dart';
import 'package:local_share/widgets/big_button.dart';

class WaitingConnectionWidget extends StatelessWidget {
  const WaitingConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocListener<SendReceiveBloc, SendReceiveBlocState>(
      listener: (context, state) {
        if (state is SendReceiveBloc_IncomingFilesRequest) {
          // show incoming transfer dialog
          showDialog(
            context: context,
            builder: (context) => IncomingTransferWidget(request: state.request),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppConstant.appPadding,
        children: [
        GestureDetector(
          onTap: () {
            // showDialog(
            //   context: context,
            //   builder: (context) => TransferCompleteCard(),
            // );
            showDialog(
              context: context,
              builder: (context) => IncomingTransferWidget(),
            );
          },
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
              WaitingAnimationWidget(),
              //SearchingAnimationWithFoundedDevices(),
              // Icon(
              //   AppIcon.receiveIcon,
              //   size: AppConstant.bigIcon,
              //   color: theme.colorScheme.primary,
              // ),
            ],
          ),
        ),

        Text(
          S.of(context).waitingForIncomingConnections,
          style: theme.textTheme.titleLarge,
        ),
        Text(
          S.of(context).yourDeviceIsReadyToReceiveFilesOtherDevicesCan,
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),

        Gap(AppConstant.appPadding * 3),
        Text(
          S.of(context).listeningForRequests,
          style: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.secondary,
          ),
        ),

        // BigButton(
        //   color: theme.colorScheme.onSecondary.withOpacity(0.3),
        //   icon: AppIcon.closeEyeIcon,
        //   withIcon: true,
        //   onTap: () {
        //     // context.read<ReceivePageBloc>().add(
        //     //   RecievePageBlocEvent_ChangeVisiblity(),
        //     // );
        //   },
        //   title: S.of(context).stop,
        // ),
        ],
      ),
    );
  }
}
