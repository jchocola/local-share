import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShareReceiveSwitcher extends StatelessWidget {
  const ShareReceiveSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoSlidingSegmentedControl(
      groupValue: '1',
      children: {
      
      '1' : Text('Send'),
      '2': Text('Receive')
    }, onValueChanged: (value) {});
  }
}
