import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/bloc/setting_bloc.dart';
import 'package:local_share/widgets/custom_switcher.dart';
import 'package:local_share/widgets/setting_title.dart';

class TransferSetting extends StatelessWidget {
  const TransferSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text('Transfer Settings', style: theme.textTheme.titleMedium),

        BlocBuilder<SettingBloc, SettingBlocState>(
          builder: (context, state) {
            if (state is SettingBlocState_loaded) {
              return Card(
                child: Column(
                  children: [
                    SettingTitle(
                      icon: AppIcon.directoryIcon,
                      title: 'Download Location',
                      subtitle: 'Where received files are saved.',
                      trailingWidget: SizedBox(
                        width: size.width * 0.3,
                        child: Text(state.downloadLocation )),
                    ),
                    Divider(),
                    SettingTitle(
                      icon: AppIcon.deleteFile,
                      title: 'Overwrite Existing Files',
                      subtitle:
                          'If disabled, duplicate files are renamed automatically.',
                      trailingWidget: CustomSwitcher(
                        value: state.overwriteExistingFile,
                        onChanged: (_) => context.read<SettingBloc>().add(SettingBlocEvent_toogleOverwriteExistingFile()),
                      ),
                    ),
                    Divider(),
                    SettingTitle(
                      icon: AppIcon.fileCheck,
                      title: 'Auto Accept Small Files',
                      subtitle:
                          'Automatically accept transfers under 10MB from known devices.',
                      trailingWidget: CustomSwitcher(
                        value: state.autoAcceptSmallFile,
                       onChanged: (_) => context.read<SettingBloc>().add(SettingBlocEvent_toogleAutoAcceptSmallFile()), 
                      ),
                    ),
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
