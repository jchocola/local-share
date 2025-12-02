import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/files_to_send_widget.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/note.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/profile_info_widget.dart';
import 'package:local_share/widgets/appbar.dart';
import 'package:local_share/widgets/big_button.dart';

class ConfirmTransferPage extends StatelessWidget {
  const ConfirmTransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Confirm Transfer'),
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
        spacing: AppConstant.appPadding/2,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: AppConstant.appPadding,
                children: [
                  ProfileInfoWidget(),
                  FilesToSendWidget(),
                  NoteWidget(),
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
                  title: 'Cancel',
                  color: theme.scaffoldBackgroundColor,
                  textColor: theme.colorScheme.onSecondary,
                ),
              ),
              Expanded(
                flex: 1,
                child: BigButton(
                  title: 'Send Files',
                     color: theme.colorScheme.primary,
                  withIcon: true,
                  icon: AppIcon.sendIcon,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
