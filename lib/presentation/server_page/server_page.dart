import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/note.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/send_via_qr_page.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/widget/host_text_copy.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/widget/qr_widget.dart';
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
      child: buildOpenedServer(context),
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
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: AppConstant.appPadding/2,
              children: [
                Center(child: QrWidget()),
                HostTextCopy(),
                ShareReceiveSwitcher(),
                ServerInfoCard(),
              ],
            ),
          ),
        ),

        ReceivedFileWidget(),
      ],
    );
  }
}
