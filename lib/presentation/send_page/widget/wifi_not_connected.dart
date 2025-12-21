import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';

class WifiNotConnected extends StatelessWidget {
  const WifiNotConnected({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Column(
          children: [
            Text('Wifi not connected'),
            Text('Please allow us to'),

            ElevatedButton(
              onPressed: () {
               context.read<SendReceiveBloc>().add(
                          SendReceiveBlocEvent_nearbyServiceInit(),
                        ); 
              },
              child: Text('Retry Again'),
            ),

            ElevatedButton(
              onPressed: () {
               context.read<SendReceiveBloc>().add(
                          SendReceiveBlocEvent_openWiFiSetting(),
                        );
              },
              child: Text('Open WiFi settings'),
            ),
          ],
        ),
      ),
    );
  }
}
