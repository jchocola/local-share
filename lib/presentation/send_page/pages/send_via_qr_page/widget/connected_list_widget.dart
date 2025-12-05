import 'package:flutter/material.dart';
import 'package:local_share/widgets/other_device_card.dart';

class ConnectedListWidget extends StatelessWidget {
  const ConnectedListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(2) Connected Device'),
        Card(child: Column(
          children: [
            OtherDeviceCard(),
            OtherDeviceCard(),
          ],
        ))
        ]);
  }
}
