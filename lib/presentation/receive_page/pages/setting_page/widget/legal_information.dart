import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/custom_switcher.dart';
import 'package:local_share/widgets/setting_title.dart';

class LegalInformation extends StatelessWidget {
  const LegalInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('Legal Information', style: theme.textTheme.titleMedium),

        Card(
          child: Column(
            children: [

                SettingTitle(
                icon: AppIcon.infoIcon,
                title: 'About App',
                subtitle: '',
               // trailingWidget: Text('Light'),
              ), 
              Divider(), 
                SettingTitle(
                icon: AppIcon.termSeriveIcon,
                title: 'Terms of Service',
                subtitle: '',
               // trailingWidget: Text('Light'),
              ), 
              Divider(),
              SettingTitle(
                icon: AppIcon.privacyPolicyIcon,
                title: 'Privacy Policy',
                subtitle: '',
               // trailingWidget: Text('Light'),
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
