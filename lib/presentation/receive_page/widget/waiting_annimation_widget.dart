import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:lottie/lottie.dart';

class WaitingAnimationWidget extends StatelessWidget {
  const WaitingAnimationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Lottie.asset(
      'assets/Waiting_Animation.json',
      width: size.width * 0.7,
      height: size.width * 0.7,
    );
  }
}

