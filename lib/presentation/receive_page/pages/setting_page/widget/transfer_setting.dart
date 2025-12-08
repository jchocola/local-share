import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/bloc/setting_bloc.dart';
import 'package:local_share/widgets/custom_switcher.dart';
import 'package:local_share/widgets/setting_title.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TransferSetting extends StatelessWidget {
  const TransferSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;


  //TODO
    void setChunkSize() {
      showModalBottomSheet(
        context: context,
        showDragHandle: true,

        builder: (context) {
          return Column(
            children: [
              SfSlider(
                activeColor: theme.colorScheme.primary,
                inactiveColor: theme.colorScheme.onSecondary.withOpacity(0.4),
                showLabels: true,
                showDividers: true,
                interval: 32,
                showTicks: true,
                min: 32,
                max: 256,
                value: 64,
                onChanged: (value) {},
              ),
            ],
          );
        },
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppConstant.appPadding,
      children: [
        Text(
          S.of(context).transferSettings,
          style: theme.textTheme.titleMedium,
        ),

        BlocBuilder<SettingBloc, SettingBlocState>(
          builder: (context, state) {
            if (state is SettingBlocState_loaded) {
              return Card(
                child: Column(
                  children: [
                    SettingTitle(
                      icon: AppIcon.directoryIcon,
                      title: S.of(context).downloadLocation,
                      subtitle: S.of(context).whereReceivedFilesAreSaved,
                      trailingWidget: SizedBox(
                        width: size.width * 0.3,
                        child: Text(state.downloadLocation),
                      ),
                    ),
                    Divider(),
                    SettingTitle(
                      icon: AppIcon.deleteFile,
                      title: S.of(context).overwriteExistingFiles,
                      subtitle: S
                          .of(context)
                          .ifDisabledDuplicateFilesAreRenamedAutomatically,
                      trailingWidget: CustomSwitcher(
                        value: state.overwriteExistingFile,
                        onChanged: (_) => context.read<SettingBloc>().add(
                          SettingBlocEvent_toogleOverwriteExistingFile(),
                        ),
                      ),
                    ),
                    Divider(),
                    SettingTitle(
                      icon: AppIcon.fileCheck,
                      title: S.of(context).autoAcceptSmallFiles,
                      subtitle: S
                          .of(context)
                          .automaticallyAcceptTransfersUnder10mbFromKnownDevices,
                      trailingWidget: CustomSwitcher(
                        value: state.autoAcceptSmallFile,
                        onChanged: (_) => context.read<SettingBloc>().add(
                          SettingBlocEvent_toogleAutoAcceptSmallFile(),
                        ),
                      ),
                    ),

                    Divider(),
                    SettingTitle(
                      icon: AppIcon.chunkIcon,
                      title: S.of(context).chunkSize,
                      subtitle: S
                          .of(context)
                          .theSizeOfAPieceOfDataDuringTransferring,
                      trailingWidget: TextButton(
                        onPressed: setChunkSize,
                        child: Text('64 MB'),
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
