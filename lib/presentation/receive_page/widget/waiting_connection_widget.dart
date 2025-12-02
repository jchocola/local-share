import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/receive_page/widget/incoming_transfer_widget.dart';
import 'package:local_share/presentation/send_page/widget/searching_animation.dart';

class WaitingConnectionWidget extends StatelessWidget {
  const WaitingConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: AppConstant.appPadding,
      children: [

        GestureDetector(
          onTap: () {
              showDialog(context: context, builder: (context) => IncomingTransferWidget());
          },
          child: Stack(
            alignment: AlignmentGeometry.center,
            children: [
           
            SearchingAnimation(),
             Icon(AppIcon.receiveIcon,size: AppConstant.bigIcon, color: theme.colorScheme.primary,),
          ]),
        ),

        Text('Waiting for incoming connections...' , style: theme.textTheme.titleLarge,),
        Text(
          "Your device is ready to receive files. Other devices can send files to you when you're visible on the network.",
          style: theme.textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),

        Gap(AppConstant.appPadding * 3),
        Text('Listening for requests', style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.secondary
        )),
      ],
    );
  }
}
