import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/blocs/server_bloc.dart';
import 'package:local_share/presentation/server_page/bloc/server_page_bloc.dart';

class ShareReceiveSwitcher extends StatelessWidget {
  const ShareReceiveSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServerBloc, ServerBlocState>(
      builder: (context, state) {
        if (state is ServerBlocState_opened) {
          return CupertinoSlidingSegmentedControl(
            groupValue: state.switcherValue,
            children: {
              AppConstant.SEND_KEY: Text('Send'),
              AppConstant.RECEIVE_KEY: Text('Receive'),
            },
            onValueChanged: (value) {
              context.read<ServerBloc>().add(
                ServerBlocState_changeSwitcherValue(value: value!),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
