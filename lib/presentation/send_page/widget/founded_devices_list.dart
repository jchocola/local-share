import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:local_share/presentation/blocs/send_receive_bloc.dart';
import 'package:local_share/presentation/send_page/bloc/picked_nearby_device_bloc.dart';
import 'package:local_share/widgets/other_device_card.dart';

class FoundedDevicesList extends StatelessWidget {
  const FoundedDevicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendReceiveBloc, SendReceiveBlocState>(
      builder: (context, state) {
        if (state is SendReceiveBloc_foundedDevices) {
          return Card(
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) => OtherDeviceCard(
                device: state.devices[index],
                onTap: () {
                  context.read<PickedNearbyDeviceBloc>().add(
                    PickedNearbyDeviceBlocEvent_pickDevice(
                      device: state.devices[index],
                    ),
                  );
                  context.push('/send_page/confirm_transfer');
                },
              ),
              separatorBuilder: (context, index) => Divider(),
              itemCount: state.devices.length,
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
