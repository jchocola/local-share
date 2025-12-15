import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:lottie/lottie.dart';

class WaitingAnimationWidget extends StatelessWidget {
  const WaitingAnimationWidget({super.key});
  static final Random _random = Random();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return BlocBuilder<SendReceiveBloc, SendReceiveBlocState>(
      builder: (context, state) {
        if (state is SendReceiveBloc_foundedDevices) {
          return Stack(
            children: [
              Lottie.asset(
                'assets/Waiting_Animation.json',
                width: size.width * 0.7,
                height: size.width * 0.7,
              ),
              ...List.generate(state.devices.length, (index) {
                return Positioned(
                      left: _random.nextDouble() * 200,
                      top: _random.nextDouble() * 200,
                  child: CustomAvatar(name: state.devices[index].info.displayName,));
              }),
            ],
          );
        } else {
          return Lottie.asset(
            'assets/Waiting_Animation.json',
            width: size.width * 0.7,
            height: size.width * 0.7,
          );
        }
      },
    );
  }
}
