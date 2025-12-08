import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/generated/l10n.dart';

class NoteWidget2 extends StatelessWidget {
  const NoteWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConstant.appPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstant.appPadding),
        color: theme.colorScheme.onSecondary.withOpacity(0.1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppConstant.appPadding/2,
        children: [
          Text(S.of(context).transferInfo, style: theme.textTheme.titleMedium),
          Text(S.of(context).makeSureThatYouAndTheRecipientAreOnThe , style: theme.textTheme.bodySmall,),
          Text(
            S.of(context).filesWillBeTransferredOverLocalNetwork,
            style: theme.textTheme.bodySmall,
          ),
          Text(
            S.of(context).noInternetConnectionRequired,
            style: theme.textTheme.bodySmall,
          ),
          Text(
            S.of(context).transferSpeedDependsOnNetworkQualityAndSettedChunkSize,
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
