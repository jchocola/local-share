import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';

class TransferCompleteCard extends StatelessWidget {
  const TransferCompleteCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: AppConstant.appPadding,
          children: [
            Icon(AppIcon.doneIcon, size: AppConstant.bigIcon*2, color: theme.colorScheme.secondary,),
            Text('Transfer Complete!' , style: theme.textTheme.titleMedium,),

            Text('All files have been successfully transferred', style: theme.textTheme.bodyMedium,),

            Gap(AppConstant.appPadding * 2),
            Text('Returning to Receive Screen' ,style: theme.textTheme.bodySmall,),
          ],
        ),
      ),
    );
  }
}
