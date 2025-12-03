import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';
import 'package:local_share/presentation/send_page/pages/profile_page/profile_page.dart';
import 'package:local_share/presentation/send_page/widget/context_menu.dart';
import 'package:local_share/presentation/send_page/widget/founded_devices_list.dart';
import 'package:local_share/presentation/send_page/widget/invisible_widget.dart';
import 'package:local_share/presentation/send_page/widget/picked_files.dart';
import 'package:local_share/presentation/send_page/widget/searching_animation.dart';
import 'package:local_share/presentation/send_page/widget/searching_for_devices.dart';
import 'package:local_share/widgets/appbar.dart';
import 'package:local_share/widgets/other_device_card.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        withLeading: true,
        withTrailing: true,
        trailing: BlocBuilder<SendPageBloc, SendPageBlocState>(
          builder: (context, state) {
            if (state is SendPageBlocState_loaded) {
              return IconButton(
                onPressed: () => context.read<SendPageBloc>().add(
                  SendPageBlocEvent_ChangeVisiblity(),
                ),
                icon: Icon(
                  state.visible ? AppIcon.openEyeIcon : AppIcon.closeEyeIcon,
                ),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        leading: Padding(
          padding: EdgeInsetsGeometry.only(left: AppConstant.appPadding),
          child: GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (context) => ProfilePage());
            },
            child: CircleAvatar(),
          ),
        ),
        title: 'Local Share',
      ),
      body: buildBody(context),

      floatingActionButton: FloatingActionButton.small(
        onPressed: () async{
          await menu.show(context);
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
      child: BlocBuilder<SendPageBloc, SendPageBlocState>(
        builder: (context, state) {
          if (state is SendPageBlocState_loaded) {
            if (state.visible) {
              return Column(
                spacing: AppConstant.appPadding,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchingForDevices(),
                  Gap(AppConstant.appPadding * 3),

                  FoundedDevicesList(),
                  // SearchingAnimation(),
                  Spacer(),
                  PickedFiles(),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: InvisibleWidget())],
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
