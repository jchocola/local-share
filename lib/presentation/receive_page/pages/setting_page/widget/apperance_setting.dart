import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/bloc/setting_bloc.dart';
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
        Text(S.of(context).appereanceSettings, style: theme.textTheme.titleMedium),

        BlocBuilder<SettingBloc, SettingBlocState>(
          builder: (context, state) {
            if (state is SettingBlocState_loaded) {
              return Card(
                child: Column(
                  children: [
                    SettingTitle(
                      icon: AppIcon.languageIcon,
                      title: S.of(context).language,
                      subtitle: 'English',
                      // trailingWidget: Text('Light'),
                    ),
                    Divider(),
                    SettingTitle(
                      icon: AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? AppIcon.lightThemeIcon:  AppIcon.darkThemeIcon,
                      title: S.of(context).applicationTheme,
                      subtitle: S.of(context).chooseBetweenLightDark,
                      trailingWidget: Text(AdaptiveTheme.of(context).mode == AdaptiveThemeMode.light ? S.of(context).light : S.of(context).dark),
                      onTap: () => AdaptiveTheme.of(context).setThemeMode( AdaptiveTheme.of(context).mode  == AdaptiveThemeMode.light ? AdaptiveThemeMode.dark : AdaptiveThemeMode.light)
                    ),
                    Divider(),
                    SettingTitle(
                      icon: AppIcon.notificationOffIcon,
                      title: S.of(context).transferNotifications,
                      subtitle:
                          S.of(context).receiveAlertsForIncomingRequestsAndCompletions,
                      trailingWidget: CustomSwitcher(
                        value: state.transferNotification,
                        onChanged: (_) => context.read<SettingBloc>().add(SettingBlocEvent_toogleTransferNotification()),
                      ),
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
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
}
