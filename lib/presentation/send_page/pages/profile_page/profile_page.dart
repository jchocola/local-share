import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/blocs/current_device_bloc.dart';
import 'package:local_share/presentation/send_page/pages/confirm_transfer/widget/profile_info_widget.dart';
import 'package:local_share/widgets/info_listile.dart';
import 'package:wiredash/wiredash.dart';

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
            BlocBuilder<CurrentDeviceBloc, CurrentDeviceBlocState>(
              builder: (context, state) {
                if (state is CurrentDeviceBlocState_loaded) {
                  return ProfileInfoWidget(deviceInfoModel: state.deviceInfo , nearbyDeviceInfo: state.nearbyDeviceInfo,);
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Divider(),
            InfoListile(
              icon: AppIcon.settingIcon,
              title: S.of(context).settings,
              onTap: () {
                context.push('/receive_page/setting');
                context.pop();
              },
            ),
            // InfoListile(icon: AppIcon.historyIcon, title: 'Transfer History'),
            InfoListile(icon: AppIcon.feedbackIcon, title: S.of(context).sendFeedback, onTap: () {
               Wiredash.of(context).show(inheritMaterialTheme: true);
            },),
            // InfoListile(
            //   icon: AppIcon.resetIcon,
            //   title: S.of(context).resetDeviceId,
            //   onTap: () {
            //     context.read<CurrentDeviceBloc>().add(
            //       CurrentDeviceBlocEvent_resetDeviceID(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
