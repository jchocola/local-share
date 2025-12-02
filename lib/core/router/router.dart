import 'package:go_router/go_router.dart';
import 'package:local_share/main_page.dart';
import 'package:local_share/presentation/receive_page/receive_page.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/confirm_transfer_page.dart';
import 'package:local_share/presentation/send_page/send_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/send_page',

  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainPage(navigationShell: navigationShell);
      },

      branches: [
        ///
        /// ВЕТВЬ 1: (SHARING)
        ///
        
        StatefulShellBranch(routes: [
          GoRoute(path: '/send_page', builder: (context, state) => const SendPage(), routes: [
            GoRoute(path: '/confirm_transfer', builder: (context, state) => const ConfirmTransferPage(),)
          ])
        ]),
        

        ///
        /// ВЕТВЬ 2: (RECEIVING)
        ///
        
         StatefulShellBranch(routes: [
          GoRoute(path: '/receive_page', builder: (context, state) => const ReceivePage(),)
         ]),
        
        ],
    ),
  ],
);
