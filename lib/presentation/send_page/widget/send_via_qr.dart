import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';

class SendViaQr extends StatelessWidget {
  const SendViaQr({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<PickedFilesBloc, PickedFilesBlocState>(
      builder: (context, state) {
        if (state is PickedFilesBlocStateLoaded) {
          if (state.files.isNotEmpty) {
            return GestureDetector(
              onTap: () {
                context.push('/send_page/send_via_qr');
              },
              child: Row(
                spacing: AppConstant.appPadding,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(AppIcon.qrCodeIcon, color: theme.colorScheme.primary),

                  // AnimatedTextKit(
                  //   isRepeatingAnimation: true,
                  //   animatedTexts: [
                  // WavyAnimatedText('Searching for devices...',textStyle: theme.textTheme.bodySmall , ),
                  // ])
                  Text(
                    'Not founds receiver? Try send via QR-code',
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
