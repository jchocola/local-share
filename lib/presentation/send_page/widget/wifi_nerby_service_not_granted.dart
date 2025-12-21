import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';

class WifiNerbyServiceNotGranted extends StatelessWidget {
  const WifiNerbyServiceNotGranted({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(

      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          children: [
            Text('WIFI NEARBY SERVICE  NOT GRANTED'),
            Text("Don't worry. You can transfer files"),
             Text("Allow this permission for scanning/show near devices"),
             
            ElevatedButton(
              onPressed: () {
                context.read<SendReceiveBloc>().add(
                  SendReceiveBlocEvent_nearbyServiceInit(),
                );
              },
              child: Text('Try again'),
            ),
        
            ElevatedButton(
              onPressed: () {
                context.read<SendReceiveBloc>().add(
                  SendReceiveBlocEvent_openAppSetting(),
                );
              },
              child: Text('Open App Setting'),
            ),
          ],
        ),
      ),
    );
  }
}
