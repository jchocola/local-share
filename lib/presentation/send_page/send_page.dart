import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/core/utils/show_toastification.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/blocs/current_device_bloc.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';
import 'package:local_share/presentation/receive_page/bloc/receive_page_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';
import 'package:local_share/presentation/send_page/pages/profile_page/profile_page.dart';
import 'package:local_share/presentation/send_page/widget/context_menu.dart';
import 'package:local_share/presentation/send_page/widget/founded_devices_list.dart';
import 'package:local_share/presentation/send_page/widget/invisible_widget.dart';
import 'package:local_share/presentation/send_page/widget/picked_files.dart';
import 'package:local_share/presentation/send_page/widget/searching_animation.dart';
import 'package:local_share/presentation/send_page/widget/searching_animation_with_founded_list.dart';
import 'package:local_share/presentation/send_page/widget/searching_for_devices.dart';
import 'package:local_share/presentation/send_page/widget/send_via_server.dart';
import 'package:local_share/presentation/send_page/widget/wifi_nerby_service_not_granted.dart';
import 'package:local_share/presentation/send_page/widget/wifi_not_connected.dart';
import 'package:local_share/widgets/appbar.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:local_share/widgets/other_device_card.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        withLeading: true,
        withTrailing: true,
        leading: Padding(
          padding: EdgeInsetsGeometry.only(left: AppConstant.appPadding),
          child: BlocBuilder<CurrentDeviceBloc, CurrentDeviceBlocState>(
            builder: (context, state) {
              if (state is CurrentDeviceBlocState_loaded) {
                return CustomAvatar(
                  name: state.nearbyDeviceInfo?.displayName ?? '',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ProfilePage(),
                    );
                  },
                );
              } else {
                return CustomAvatar(
                  name: 'NoName',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => ProfilePage(),
                    );
                  },
                );
              }
            },
          ),
        ),
        title: S.of(context).localshare,
      ),
      body: buildBody(context),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await menu(context).show(context);
          //           void showMenu() async {
          //   showContextMenu(context, contextMenu: menu);
          //   // or
          //   // final selectedValue = await menu.show(context);
          //   // print(selectedValue);
          // }
        },
        child: Icon(AppIcon.addIcon),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppConstant.appPadding / 2,
        horizontal: AppConstant.appPadding,
      ),
      child: Column(
        spacing: AppConstant.appPadding,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SearchingForDevices(),
          SendViaServer(),
          Gap(AppConstant.appPadding * 3),

          BlocConsumer<SendReceiveBloc, SendReceiveBlocState>(
            listener: (context, state) {
              if (state is SendReceiveBlocDiscovering) {
                showSuccessToatification(context, title: S.of(context).startDiscovering, desc: S.of(context).lookingForEachOther);
              }

              if (state is SendReceiveBloc_notWifiNearbyServiceGranted) {
                showErrorToatification(
                  context,
                  title: S.of(context).wifiNearbyServiceDenied,
                  desc: S.of(context).youCantSeeOtherstheyCantSeeYou
                );
              }

              if (state is SendReceiveBloc_notWifiConnected) {
                showErrorToatification(context, title: S.of(context).wifiNotConnected,desc: S.of(context).connectToWifiOrYourPersonalInternetConnection);
              }

              if (state is SendReceiveBloc_foundedDevices) {
                showSuccessToatification(context, title: S.of(context).yohooo,desc: S.of(context).weFoundSomeone);
              }
            },

            builder: (context, state) {
              if (state is SendReceiveBlocDiscovering) {
                return SearchingAnimation();
              } else if (state is SendReceiveBloc_foundedDevices) {
                return FoundedDevicesList();
              } else if (state is SendReceiveBloc_notWifiNearbyServiceGranted) {
                return WifiNerbyServiceNotGranted();
              } else if (state is SendReceiveBloc_notWifiConnected) {
                return WifiNotConnected();
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
          //FoundedDevicesList(),
          // SearchingAnimationWithFoundedDevices(),
          Spacer(),
          PickedFiles(),
        ],
      ),
    );
  }
}
