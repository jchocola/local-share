import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/blocs/current_device_bloc.dart';
import 'package:local_share/presentation/receive_page/pages/setting_page/bloc/receive_page_bloc.dart';
import 'package:local_share/widgets/custom_avatar.dart';
import 'package:local_share/widgets/ready_to_receive_card.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return BlocBuilder<CurrentDeviceBloc, CurrentDeviceBlocState>(
      builder: (context, state) {
        if (state is CurrentDeviceBlocState_loaded) {
          return Card(
            child: Padding(
              padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
              child: Row(
                spacing: AppConstant.appPadding,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomAvatar(),
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
                          state.deviceInfo.name,
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          'Device ID: 647743',
                          style: theme.textTheme.bodySmall,
                        ),
                        Text('Online', style: theme.textTheme.bodySmall),
                        BlocBuilder<ReceivePageBloc, ReceivePageBlocState>(
                          builder: (context, receivePageState) {
                            if (receivePageState is ReceivePageBlocState_loaded) {
                             
                              return ReadyToReceiveCard(ready: receivePageState.visible);
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
