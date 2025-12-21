import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/blocs/server_bloc.dart';
import 'package:local_share/presentation/server_page/bloc/server_page_bloc.dart';

class ShareReceiveSwitcher extends StatelessWidget {
  const ShareReceiveSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ServerBloc, ServerBlocState>(
      builder: (context, state) {
        if (state is ServerBlocState_opened) {
          return CupertinoSlidingSegmentedControl(
            backgroundColor: theme.colorScheme. primary.withOpacity(0.1),
            thumbColor: theme.scaffoldBackgroundColor,
            groupValue: state.switcherValue,
            children: {
              AppConstant.SEND_KEY: Text(S.of(context).send),
              AppConstant.RECEIVE_KEY: Text(S.of(context).receive),
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
