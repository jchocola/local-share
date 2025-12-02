import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/custom_switcher.dart';
import 'package:local_share/widgets/setting_title.dart';

class AppearanceSetting extends StatelessWidget {
  const AppearanceSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('Appereance Settings', style: theme.textTheme.titleMedium),

        Card(
          child: Column(
            children: [
              SettingTitle(
                icon: AppIcon.darkThemeIcon,
                title: 'Application Theme',
                subtitle: 'Choose between light, dark',
                trailingWidget: Text('Light'),
              ),
              Divider(),
              SettingTitle(

                icon: AppIcon.notificationOffIcon,
                title: 'Transfer Notifications',
                subtitle:
                    'Receive alerts for incoming requests and completions.',
                    trailingWidget: CustomSwitcher(),
              ),
              // Divider(),
              // SettingTitle(
              //   icon: AppIcon.fileCheck,
              //   title: 'Auto Accept Small Files',
              //   subtitle:
              //       'Automatically accept transfers under 10MB from known devices.',
              //       trailingWidget: CustomSwitcher(),
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
