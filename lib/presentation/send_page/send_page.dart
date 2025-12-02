import 'package:flutter/material.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Page'),
      ),
      body: const Center(
        child: Text('This is the Send Page'),
      ),
    );
  }
}
