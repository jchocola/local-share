import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';

class WifiNerbyServiceNotGranted extends StatelessWidget {
  const WifiNerbyServiceNotGranted({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('NOT WIIF NEARBY SERVICE GRANTED'),
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
    );
  }
}
