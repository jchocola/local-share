import 'package:flutter/material.dart';
import 'package:local_share/widgets/other_device_card.dart';

class FoundedDevicesList extends StatelessWidget {
  const FoundedDevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context,index)=> OtherDeviceCard(), separatorBuilder: (context,index)=> Divider(), itemCount: 3)
    );
  }
}
