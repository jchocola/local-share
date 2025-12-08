import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';
import 'package:local_share/presentation/server_page/server_page.dart';

class SendViaServer extends StatelessWidget {
  const SendViaServer({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PickedFilesBloc, PickedFilesBlocState>(
      builder: (context, state) {
        if (state is PickedFilesBlocStateLoaded) {
          if (state.files.isNotEmpty) {
            return GestureDetector(
              onTap: () {
                // go to server page
                context.go('/server');
              },
              child: Row(
                spacing: AppConstant.appPadding,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(AppIcon.serverIcon, color: theme.colorScheme.primary),

                  // AnimatedTextKit(
                  //   isRepeatingAnimation: true,
                  //   animatedTexts: [
                  // WavyAnimatedText('Searching for devices...',textStyle: theme.textTheme.bodySmall , ),
                  // ])
                  Text(
                    S.of(context).notFoundsReceiverTrySendViaServer,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
