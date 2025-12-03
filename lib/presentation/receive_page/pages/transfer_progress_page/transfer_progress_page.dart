import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/receive_page/pages/transfer_progress_page/widget/files_transfer_progress.dart';
import 'package:local_share/presentation/receive_page/pages/transfer_progress_page/widget/note.dart';
import 'package:local_share/presentation/receive_page/pages/transfer_progress_page/widget/overrall_progress_widget.dart';
import 'package:local_share/presentation/receive_page/pages/transfer_progress_page/widget/transfer_to_widget.dart';
import 'package:local_share/widgets/appbar.dart';

class TransferProgressPage extends StatelessWidget {
  const TransferProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Appbar(title: 'Transfer Progress'), body: buildBody(context),);
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstant.appPadding/2 , horizontal: AppConstant.appPadding),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TransferToWidget(),
            OverrallProgressWidget(),
            FilesTransferProgress(),
            Note()
          ],
        ),
      ),
    );
  }
}
