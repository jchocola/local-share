import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/widgets/ready_to_receive_card.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Row(
          children: [
            Expanded(flex: 1, child: CircleAvatar(radius: size.width * 0.07,)),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppConstant.appPadding / 2,
                children: [
                  Text("Jenny's iPad Pro", style: theme.textTheme.titleMedium),
                  Text('Device ID: 647743', style: theme.textTheme.bodySmall),
                  Text('Online', style: theme.textTheme.bodySmall),
                  ReadyToReceiveCard(ready: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
