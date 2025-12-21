import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';

class WifiNerbyServiceNotGranted extends StatelessWidget {
  const WifiNerbyServiceNotGranted({super.key});

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            Text(S.of(context).wifiNearbyServiceDenied,style: theme.textTheme.titleLarge,),
           
               Text(S.of(context).youCanStillTransferFiles ,style: theme.textTheme.bodyMedium),
            Text(S.of(context).makeSureThatYouAndTheRecipientAreOnThe , style: theme.textTheme.bodyMedium),
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
                  SendReceiveBlocEvent_openAppSetting(),
                );
              },
              child: Text(S.of(context).openAppSetting),
            ),
          ],
        ),
      ),
    );
  }
}
