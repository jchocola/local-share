import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/core/utils/show_toastification.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/picked_files_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/picked_nearby_device_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/files_to_send_widget.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/note.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/profile_info_widget.dart';
import 'package:local_share/presentation/send_page/widget/picked_files.dart';
import 'package:local_share/widgets/appbar.dart';
import 'package:local_share/widgets/big_button.dart';
import 'dart:io';

class ConfirmTransferPage extends StatelessWidget {
  const ConfirmTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: S.of(context).confirmTransfer),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.appPadding / 2,
        horizontal: AppConstant.appPadding,
      ),
      child: Column(
        spacing: AppConstant.appPadding / 2,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: AppConstant.appPadding,
                children: [
                  BlocBuilder<
                    PickedNearbyDeviceBloc,
                    PickedNearbyDeviceBlocState
                  >(
                    builder: (context, state) {
                      if (state is PickedNearbyDeviceBlocState_picked) {
                        return ProfileInfoWidget(
                          nearbyDeviceInfo: state.device.info,
                        );
                      } else {
                        return ProfileInfoWidget();
                      }
                    },
                  ),
                  PickedFiles(),
                  //FilesToSendWidget(),
                  NoteWidget2(),
                ],
              ),
            ),
          ),

          Row(
            spacing: AppConstant.appPadding,
            children: [
              Expanded(
                flex: 1,
                child: BigButton(
                  title: S.of(context).cancel,
                  color: theme.scaffoldBackgroundColor,
                  textColor: theme.colorScheme.onSecondary,
                  onTap: () => context.pop(),
                ),
              ),
              Expanded(
                flex: 1,
                child:
                    BlocBuilder<
                      PickedNearbyDeviceBloc,
                      PickedNearbyDeviceBlocState
                    >(
                      builder: (context, state) {
                        if (state is PickedNearbyDeviceBlocState_picked) {
                          return BlocListener<
                            SendReceiveBloc,
                            SendReceiveBlocState
                          >(
                            listener: (context, state) {
                              if (state is SendReceiveBloc_ConnectedDevice) {
                                showSuccessToatification(
                                  context,
                                  title:
                                      'Connected to ${state.device.info.displayName}',
                                );
                              }
                            },

                            child: BigButton(
                              title: S.of(context).sendFiles,
                              color: theme.colorScheme.primary,
                              withIcon: true,
                              icon: AppIcon.sendIcon,
                              onTap: () {
                                final pickedFilesBloc = context
                                    .read<PickedFilesBloc>();
                                if (pickedFilesBloc.files.isEmpty) {
                                  showWarningToatification(
                                    context,
                                    title: 'No file picked',
                                  );
                                } else {
                                  context.read<SendReceiveBloc>().add(
                                    SendReceiveBlocEvent_connectDevice(
                                      device: state.device,
                                    ),
                                  );

                                  // Convert picked files to File objects
                                  final files = pickedFilesBloc.files
                                      .map((fileModel) => File(fileModel.path))
                                      .toList();

                                  // Send files with ACK for reliability
                                  // context.read<SendPageBloc>().add(
                                  //   SendPageBlocEvent_sendFiles(files: files)
                                  // );
                                }
                              },
                            ),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
              ),
            ],
          ),

          // // Show progress indicator if sending
          // if (state is SendPageBlocState_sending)
          //   Padding(
          //     padding: EdgeInsets.all(AppConstant.appPadding),
          //     child: Column(
          //       children: [
          //         if (state.currentFileName != null)
          //           Text('Sending: ${state.currentFileName}'),
          //         LinearProgressIndicator(value: state.progress),
          //         SizedBox(height: 10),
          //         Text('${state.sentFiles}/${state.totalFiles} files sent'),
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
