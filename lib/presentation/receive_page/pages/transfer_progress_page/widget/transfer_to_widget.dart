import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';

class TransferToWidget extends StatelessWidget {
  const TransferToWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Center(child: Text('Transferring to My Pixel 8 Pro', style: theme.textTheme.titleMedium,)),
      ),
    );
  }
}
