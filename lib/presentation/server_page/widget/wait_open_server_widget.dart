import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
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
        Lottie.asset('assets/ServerConnect.json' , width: size.width * 0.6, height:size.width * 0.6 ),

        BigButton(title: 'Open Server', color: theme.colorScheme.primary),
      ],
    );
  }
}
