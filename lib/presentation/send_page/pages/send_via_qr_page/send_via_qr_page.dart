import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/widget/host_text_copy.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/widget/connected_list_widget.dart';
import 'package:local_share/presentation/send_page/pages/send_via_qr_page/widget/qr_widget.dart';
import 'package:local_share/widgets/big_button.dart';

class SendViaQrPage extends StatelessWidget {
  const SendViaQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Send via QR-code')),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstant.appPadding / 2,
        horizontal: AppConstant.appPadding,
      ),
      child: Column(
        spacing: AppConstant.appPadding,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: QrWidget()),
          Center(child: Text('Получатель должен находиться с вами в одной сеть' , style: theme.textTheme.bodySmall,)),
          HostTextCopy(),
          ConnectedListWidget(),
          BigButton(title: 'Start Sending', color: theme.colorScheme.primary),
        ],
      ),
    );
  }
}
