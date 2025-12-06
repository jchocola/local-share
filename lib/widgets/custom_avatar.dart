import 'package:avatar_plus/avatar_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/presentation/blocs/current_device_bloc.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({super.key , this.size = 50});
  final double size; 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentDeviceBloc, CurrentDeviceBlocState>(
      builder: (context, state) {

        if (state is CurrentDeviceBlocState_loaded) {
          return AvatarPlus(state.deviceInfo.name, height: size,width: size,);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
