import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/data/model/device_info_model.dart';
import 'package:local_share/presentation/blocs/current_device_bloc.dart';
import 'package:local_share/presentation/receive_page/bloc/receive_page_bloc.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:local_share/widgets/ready_to_receive_card.dart';
import 'package:nearby_service/nearby_service.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key, this.deviceInfoModel , this.nearbyDeviceInfo});
  final DeviceInfoModel? deviceInfoModel;
  final NearbyDeviceInfo? nearbyDeviceInfo;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Row(
          spacing: AppConstant.appPadding,
          children: [
            Expanded(
              flex: 1,
              child: CustomAvatar(name: nearbyDeviceInfo?.displayName ?? 'Noo name'),
              // child: CircleAvatar(radius: size.width * 0.07),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: AppConstant.appPadding / 2,
                children: [
                  Text(
                    nearbyDeviceInfo?.displayName ?? 'No name',
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    'Device ID: ${nearbyDeviceInfo?.id}',
                    style: theme.textTheme.bodySmall,
                  ),

                  Text(
                    'IP: ${deviceInfoModel?.IP}',
                    style: theme.textTheme.bodySmall,
                  ),
                  // Text('Online', style: theme.textTheme.bodySmall),
                  // BlocBuilder<ReceivePageBloc, ReceivePageBlocState>(
                  //   builder: (context, receivePageState) {
                  //     if (receivePageState
                  //         is ReceivePageBlocState_loaded) {
                  //       return ReadyToReceiveCard(
                  //         ready: receivePageState.visible,
                  //       );
                  //     } else {
                  //       return CircularProgressIndicator();
                  //     }
                  //   },
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
