import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/core/utils/show_toastification.dart';
import 'package:local_share/presentation/blocs/server_bloc.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/note.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/send_via_qr_page.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/widget/host_text_copy.dart';
import 'package:local_share/widgets/qr_widget.dart';
import 'package:local_share/presentation/server_page/widget/received_file_widget.dart';
import 'package:local_share/presentation/server_page/widget/server_info_card.dart';
import 'package:local_share/presentation/server_page/widget/share_receive_switcher.dart';
import 'package:local_share/presentation/server_page/widget/wait_open_server_widget.dart';
import 'package:local_share/widgets/note_widget.dart';

class ServerPage extends StatelessWidget {
  const ServerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ServerPage')),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstant.appPadding / 2,
        horizontal: AppConstant.appPadding,
      ),
      child: BlocConsumer<ServerBloc, ServerBlocState>(
        listener: (context, state) {
          if (state is ServerBlocState_error) {
            showErrorToatification(
              context,
              title: AppErrorConverter(error: state.error),
            );
          }
          if (state is ServerBlocState_success) {
            showSuccessToatification(
              context,
              title: AppErrorConverter(error: state.success),
            );
          }
        },

        builder: (context, state) {
          if (state is ServerBlocState_waiting) {
            return buildWaitingOpenServer(context);
          } else if (state is ServerBlocState_opened) {
            return buildOpenedServer(context);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      //child: buildWaitingOpenServer(context),
    );
  }

  Widget buildWaitingOpenServer(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          WaitOpenServerWidget(),

          NoteWidget(
            title: 'Убедитесь , что вы и получатель находитесь в одной сети',
          ),
          NoteWidget(
            title:
                'Используя этот метод, вы можете обменивать с любыми устройствами с разным ОС',
          ),
        ],
      ),
    );
  }

  Widget buildOpenedServer(BuildContext context) {
    return BlocBuilder<ServerBloc, ServerBlocState>(
      builder: (context, state) {
        if (state is ServerBlocState_opened) {
          final sendUrl = context.watch<ServerBloc>().serverRepo.sendUrl;
          final receiveUrl = context.watch<ServerBloc>().serverRepo.receiveUrl;
          return Column(
            spacing: AppConstant.appPadding,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: AppConstant.appPadding / 2,
                    children: [
                      Center(child: QrWidget(data: state.switcherValue == AppConstant.SEND_KEY ? sendUrl : receiveUrl,)),
                      HostTextCopy(data:   state.switcherValue == AppConstant.SEND_KEY ? sendUrl : receiveUrl,),
                      ShareReceiveSwitcher(),
                      ServerInfoCard(),
                    ],
                  ),
                ),
              ),

              ReceivedFileWidget(),
            ],
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
