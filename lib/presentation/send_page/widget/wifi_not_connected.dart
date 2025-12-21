import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';

class WifiNotConnected extends StatelessWidget {
  const WifiNotConnected({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            Text(S.of(context).wifiNotConnected, style: theme.textTheme.titleLarge,),
          

            ElevatedButton(
              onPressed: () {
                context.read<SendReceiveBloc>().add(
                  SendReceiveBlocEvent_nearbyServiceInit(),
                );
              },
              child: Text(S.of(context).tryAgain),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<SendReceiveBloc>().add(
                  SendReceiveBlocEvent_openWiFiSetting(),
                );
              },
              child: Text(S.of(context).openWifiSettings),
            ),
          ],
        ),
      ),
    );
  }
}
