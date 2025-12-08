import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/bloc/setting_bloc.dart';
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
        Text(S.of(context).legalInformation, style: theme.textTheme.titleMedium),

        Card(
          child: Column(
            children: [

                SettingTitle(
                icon: AppIcon.infoIcon,
                title: S.of(context).aboutApp,
                subtitle: '',
                onTap: () => context.push('/receive_page/setting/about_app'),
               // trailingWidget: Text('Light'),
              ), 
              Divider(), 
                SettingTitle(
                icon: AppIcon.termSeriveIcon,
                title: S.of(context).termsOfService,
                subtitle: '',
                onTap: () => context.read<SettingBloc>().add(SettingBlocEvent_termsOfServiceTapped()),
               // trailingWidget: Text('Light'),
              ), 
              Divider(),
              SettingTitle(
                icon: AppIcon.privacyPolicyIcon,
                title: S.of(context).privacyPolicy,
                subtitle: '',
                 onTap: () => context.read<SettingBloc>().add(SettingBlocEvent_privacyPolicyTapped()),
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
