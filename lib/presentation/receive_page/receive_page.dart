import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/receive_page/widget/waiting_connection_widget.dart';
import 'package:local_share/widgets/appbar.dart';

class ReceivePage extends StatelessWidget {
  const ReceivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        withTrailing: true,
        trailing: IconButton(
          onPressed: () {
            context.push('/receive_page/setting');
          },
          icon: Icon(AppIcon.settingIcon),
        ),
        title: 'Receive',
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppConstant.appPadding / 2,
        horizontal: AppConstant.appPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [WaitingConnectionWidget()],
      ),
    );
  }
}
