import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';
import 'package:local_share/widgets/appbar.dart';

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
                onPressed: () => context.read<SendPageBloc>().add(SendPageBlocEvent_ChangeVisiblity()),
                icon: Icon(state.visible ? AppIcon.openEyeIcon : AppIcon.closeEyeIcon),
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
        leading: Padding(
          padding: EdgeInsetsGeometry.only(left: AppConstant.appPadding),
          child: CircleAvatar(),
        ),
        title: 'Local Share',
      ),
      body: const Center(child: Text('This is the Send Page')),

      floatingActionButton: FloatingActionButton.small(
        onPressed: () {},
        child: Icon(AppIcon.addIcon),
      ),
    );
  }
}
