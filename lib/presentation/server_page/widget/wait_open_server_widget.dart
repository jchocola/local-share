import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/blocs/server_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart'; // Add this import
import 'package:local_share/presentation/server_page/server_page.dart';
import 'package:local_share/widgets/big_button.dart';
import 'package:lottie/lottie.dart';

class WaitOpenServerWidget extends StatelessWidget {
  const WaitOpenServerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        Lottie.asset(
          'assets/ServerConnect.json',
          width: size.width * 0.6,
          height: size.width * 0.6,
        ),

        BigButton(
          title: 'Open Server',
          color: theme.colorScheme.primary,
          onTap: () {
            // Get picked files from the bloc
            final pickedFiles = context.read<PickedFilesBloc>().files;

            // Pass the files when opening the server
            context.read<ServerBloc>().add(
              ServerBlocEvent_openServer(files: pickedFiles),
            );
          },
        ),
      ],
    );
  }
}
