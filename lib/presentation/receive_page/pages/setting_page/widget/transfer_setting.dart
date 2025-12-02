import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/custom_switcher.dart';
import 'package:local_share/widgets/setting_title.dart';

class TransferSetting extends StatelessWidget {
  const TransferSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('Transfer Settings', style: theme.textTheme.titleMedium),

        Card(
          child: Column(
            children: [
              SettingTitle(
                icon: AppIcon.directoryIcon,
                title: 'Download Location',
                subtitle: 'Where received files are saved.',
                trailingWidget: Text('/storage/emula...'),
              ),
              Divider(),
              SettingTitle(

                icon: AppIcon.deleteFile,
                title: 'Overwrite Existing Files',
                subtitle:
                    'If disabled, duplicate files are renamed automatically.',
                    trailingWidget: CustomSwitcher(),
              ),
              Divider(),
              SettingTitle(
                icon: AppIcon.fileCheck,
                title: 'Auto Accept Small Files',
                subtitle:
                    'Automatically accept transfers under 10MB from known devices.',
                    trailingWidget: CustomSwitcher(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
