import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/icons/app_icon.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (value) {
          navigationShell.goBranch(value);
        },
        items:  [
          BottomNavigationBarItem(
            icon: Icon(AppIcon.sendIcon),
            label: 'Send',
          ),

           BottomNavigationBarItem(
            icon: Icon(AppIcon.serverIcon),
            label: 'Server',
          ),

          BottomNavigationBarItem(
            icon: Icon(AppIcon.receiveIcon),
            label: 'Receive',
          ),
        ],
      ),
    );
  }
}
