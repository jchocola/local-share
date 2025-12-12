import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/main.dart';
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
          return BlocBuilder<SettingBloc, SettingBlocState>(
            builder: (context, state) {
              if (state is SettingBlocState_loaded) {
                return Column(
                  spacing: AppConstant.appPadding,
                  children: [
                    Text(
                      S.of(context).chunkSize,
                      style: theme.textTheme.titleLarge,
                    ),
                    Text(
                      S.of(context).theMoreTheFasterTheLessTheBetter,
                      style: theme.textTheme.titleSmall,
                    ),

                    SfSlider(
                      activeColor: theme.colorScheme.primary,
                      inactiveColor: theme.colorScheme.onSecondary.withOpacity(
                        0.4,
                      ),
                      showLabels: true,
                      showDividers: true,
                      interval: AppConstant.CHUNK_INTERVAL,
                      stepSize: AppConstant.CHUNK_INTERVAL,
                      showTicks: true,
                      min: AppConstant.MIN_CHUNK_SIZE,
                      max: AppConstant.MAX_CHUNK_SIZE,
                      value: state.chunkSize,
                      onChanged: (value) {
                        final val = value as double;
                        logger.d(value.runtimeType);
                        context.read<SettingBloc>().add(
                          SettingBlocEvent_changeChunkSize(
                            chunkSize: val.toInt(),
                          ),
                        );
                      },
                    ),

                    const Gap(AppConstant.appPadding * 3),
                    _customWidget(context, chunkSize: state.chunkSize),
                  ],
                );
              } else {
                return CircularProgressIndicator();
              }
            },
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
                    // Divider(),
                    // SettingTitle(
                    //   icon: AppIcon.fileCheck,
                    //   title: S.of(context).autoAcceptSmallFiles,
                    //   subtitle: S
                    //       .of(context)
                    //       .automaticallyAcceptTransfersUnder10mbFromKnownDevices,
                    //   trailingWidget: CustomSwitcher(
                    //     value: state.autoAcceptSmallFile,
                    //     onChanged: (_) => context.read<SettingBloc>().add(
                    //       SettingBlocEvent_toogleAutoAcceptSmallFile(),
                    //     ),
                    //   ),
                    // ),

                    Divider(),
                    SettingTitle(
                      icon: AppIcon.chunkIcon,
                      title: S.of(context).chunkSize,
                      subtitle: S
                          .of(context)
                          .theSizeOfAPieceOfDataDuringTransferring,
                      trailingWidget: TextButton(
                        onPressed: setChunkSize,
                        child: Text(S.of(context).chunksizeMb(state.chunkSize)),
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

  Widget _customWidget(context, {required int chunkSize}) {
    if (32 <= chunkSize && chunkSize <= 96) {
      return _customTitle(
        context,
        icon: AppIcon.slowIcon,
        title: 'Good',
        color: Colors.green,
      );
    } else if (96 < chunkSize && chunkSize <= 192) {
      return  _customTitle(
        context,
        icon: AppIcon.fastIcon,
        title: 'Gooood',
        color: Colors.orange,
      );
    } else if (192 < chunkSize && chunkSize <= 256) {
      return _customTitle(
        context,
        icon: AppIcon.veryFastIcon,
        title: 'Gooooooooood',
        color: Colors.red,
      );
    } else {
      return SizedBox();
    }
  }

  Widget _customTitle(
    context, {
    required IconData icon,
    required String title,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppConstant.appPadding,
      children: [
        Icon(icon, color: color),
        Text(title, style: theme.textTheme.titleMedium!.copyWith(
          color: color
        )),
      ],
    );
  }
}
