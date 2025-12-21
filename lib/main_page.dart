import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';

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

          ///
          /// Discover if value == 0
          ///
          // if (value == 0) {
          //   context.read<SendReceiveBloc>().add(
          //     SendReceiveBlocEvent_nearbyServiceDiscover(),
          //   );
          // } else {
          //   context.read<SendReceiveBloc>().add(
          //     SendReceiveBlocEvent_nearbyServiceStopDiscover(),
          //   ); 
          // }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(AppIcon.sendIcon),
            label: S.of(context).send,
          ),

          BottomNavigationBarItem(
            icon: Icon(AppIcon.serverIcon),
            label: S.of(context).server,
          ),

          // BottomNavigationBarItem(
          //   icon: Icon(AppIcon.receiveIcon),
          //   label: S.of(context).receive,
          // ),
        ],
      ),
    );
  }
}
