import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:lottie/lottie.dart';

class SearchingAnimationWithFoundedDevices extends StatefulWidget {
  const SearchingAnimationWithFoundedDevices({super.key});

  @override
  State<SearchingAnimationWithFoundedDevices> createState() =>
      _SearchingAnimationWithFoundedDevicesState();
}

class _SearchingAnimationWithFoundedDevicesState
    extends State<SearchingAnimationWithFoundedDevices> {
  final List<String> foundedDevice = [
    'Nguyen The Bac',
    'Liana',
    'Timur',
    'Atrem',
    'Zalina',
  ];

  final Random _random = Random();
  final List<Offset> _avatarPositions = [];
  int? _selectedAvatarIndex;
  Offset? _dragStartOffset;

  @override
  void initState() {
    super.initState();
    // Инициализируем случайные позиции
    for (int i = 0; i < foundedDevice.length; i++) {
      _avatarPositions.add(Offset(
        _random.nextDouble() * 200,
        _random.nextDouble() * 200,
      ));
    }
  }

  void _onPanStart(int index, DragStartDetails details) {
    setState(() {
      _selectedAvatarIndex = index;
      _dragStartOffset = details.localPosition;
    });
  }

  void _onPanUpdate(int index, DragUpdateDetails details) {
    if (_selectedAvatarIndex == index) {
      setState(() {
        _avatarPositions[index] = Offset(
          _avatarPositions[index].dx + details.delta.dx,
          _avatarPositions[index].dy + details.delta.dy,
        );
      });
    }
  }

  void _onPanEnd(int index, DragEndDetails details) {
    setState(() {
      _selectedAvatarIndex = null;
      _dragStartOffset = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        /// searching animation
        Lottie.asset(
          'assets/Searching_Animation.json',
          width: size.width * 0.7,
          height: size.width * 0.7,
        ),

        for (int i = 0; i < foundedDevice.length; i++)
          Positioned(
            left: _avatarPositions[i].dx,
            top: _avatarPositions[i].dy,
            child: DraggableAvatar(
              name: foundedDevice[i],
              index: i,
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              onTap: () {
                context.push('/send_page/confirm_transfer');
              },
              isDragging: _selectedAvatarIndex == i,
            ),
          ),
      ],
    );
  }
}

class DraggableAvatar extends StatelessWidget {
  final String name;
  final int index;
  final Function(int, DragStartDetails) onPanStart;
  final Function(int, DragUpdateDetails) onPanUpdate;
  final Function(int, DragEndDetails) onPanEnd;
  final VoidCallback onTap;
  final bool isDragging;

  const DraggableAvatar({
    super.key,
    required this.name,
    required this.index,
    required this.onPanStart,
    required this.onPanUpdate,
    required this.onPanEnd,
    required this.onTap,
    required this.isDragging,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => onPanStart(index, details),
      onPanUpdate: (details) => onPanUpdate(index, details),
      onPanEnd: (details) => onPanEnd(index, details),
      onTap: onTap,
      child: Transform.scale(
        scale: isDragging ? 1.1 : 1.0,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: isDragging
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                     
                    ),
                  ]
                : [],
          ),
          child: CustomAvatar(
            name: name,
          ),
        ),
      ),
    );
  }
}