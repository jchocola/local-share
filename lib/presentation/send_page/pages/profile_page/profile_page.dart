import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/profile_info_widget.dart';
import 'package:local_share/widgets/info_listile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProfileInfoWidget(),
            Divider(),
            InfoListile(
              icon: AppIcon.settingIcon,
              title: 'Settings',
              onTap: () {
                  context.push('/receive_page/setting');
                  
              },
            ),
            InfoListile(icon: AppIcon.historyIcon, title: 'Transfer History'),
            InfoListile(icon: AppIcon.feedbackIcon, title: 'Send Feedback'),
            InfoListile(icon: AppIcon.resetIcon, title: 'Reset Device ID'),
          ],
        ),
      ),
    );
  }
}
