import 'package:flutter/material.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/appbar.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        withTrailing: true,
        trailing: IconButton(onPressed: () {}, icon: Icon(AppIcon.settingIcon)),
        title: 'Receive',
      ),
      body: const Center(child: Text('This is the Receive Page')),
    );
  }
}
