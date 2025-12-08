import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';

class SearchingForDevices extends StatelessWidget {
  const SearchingForDevices({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      spacing: AppConstant.appPadding,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(AppIcon.signalIcon , color: theme.colorScheme.primary,),

        AnimatedTextKit(
          isRepeatingAnimation: true,
          animatedTexts: [
        WavyAnimatedText(S.of(context).searchingForDevices,textStyle: theme.textTheme.bodySmall , ),
         WavyAnimatedText(S.of(context).pleaseSelectFilesToSend,textStyle: theme.textTheme.bodySmall , ),
        ])

       // Text('' , style: theme.textTheme.bodySmall,)
      ],
    );
  }
}
