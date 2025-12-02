import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';

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
        Text('Searching for devices...' , style: theme.textTheme.bodySmall,)
      ],
    );
  }
}
