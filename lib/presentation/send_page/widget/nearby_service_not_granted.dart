import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';

class NearbyServiceNotGranted extends StatelessWidget {
  const NearbyServiceNotGranted({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Column(
          children: [
            Text('Nearby Serive not granted'),
            Text('Please allow us to'),

            ElevatedButton(
              onPressed: () {
                context.read<SendPageBloc>().add(
                  SendPageBlocEvent_NearbyServiceInit(),
                );
              },
              child: Text('Retry Again'),
            ),

            ElevatedButton(
              onPressed: () {
                context.read<SendPageBloc>().add(
                  SendPageBlocEvent_openAppSettingForAllowPermisson(),
                );
              },
              child: Text('Open service settings'),
            ),
          ],
        ),
      ),
    );
  }
}
