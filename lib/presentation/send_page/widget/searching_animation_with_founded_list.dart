import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:lottie/lottie.dart';

class SearchingAnimationWithFoundedDevices extends StatelessWidget {
  SearchingAnimationWithFoundedDevices({super.key});

  final List<String> foundedDevice = [
    'Nguyen The Bac',
    'Liana',
    'Timur',
    'Atrem',
    'Zalina',
  ];

  final Random _random = Random();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Генерируем случайные позиции для каждого устройства
    final List<Widget> avatarWidgets = [];

    for (int i = 0; i < foundedDevice.length; i++) {
      final name = foundedDevice[i];

      // Генерируем случайные координаты в пределах Stack
      // Оставляем отступы от краев, чтобы аватары не выходили за границы
      final double left = _random.nextDouble() * (size.width * 0.7 - 50);
      final double top = _random.nextDouble() * (size.width * 0.7 - 50);

      avatarWidgets.add(
        Positioned(
          left: left,
          top: top,
          child: CustomAvatar(
            name: name,
            onTap: () {
              context.push('/send_page/confirm_transfer');
            },
          ),
        ),
      );
    }

    return Stack(
      children: [
        /// searching animation
        Lottie.asset(
          'assets/Searching_Animation.json',
          width: size.width * 0.7,
          height: size.width * 0.7,
        ),

        ...avatarWidgets,
      ],
    );
  }
}
