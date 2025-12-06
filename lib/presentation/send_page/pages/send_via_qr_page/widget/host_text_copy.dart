import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';

class HostTextCopy extends StatelessWidget {
  const HostTextCopy({super.key , this.data = 'http://localhoast:8080'});
  final String data;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstant.appBorder),
      ),
      child: Row(
        spacing: AppConstant.appPadding,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(data, style: theme.textTheme.titleMedium),
          IconButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: data));
            },
            icon: Icon(AppIcon.copyIcon),
          ),
        ],
      ),
    );
  }
}
