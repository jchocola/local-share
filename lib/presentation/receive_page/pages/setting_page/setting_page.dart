import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/widget/apperance_setting.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/widget/transfer_setting.dart';
import 'package:local_share/widgets/appbar.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Appbar(title: 'Settings'), body: buiBody(context),);
  }

  Widget buiBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstant.appPadding/2 , horizontal: AppConstant.appPadding),
      child: Column(
        spacing: AppConstant.appPadding,
        children: [
          TransferSetting(),
          AppearanceSetting(),
        ],
      ),
    );
  }
}
