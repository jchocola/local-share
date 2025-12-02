import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/appbar.dart';

class SendPage extends StatelessWidget {
  const SendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        withLeading: true,
        withTrailing: true,
        trailing: IconButton(onPressed: () {}, icon: Icon(AppIcon.openEyeIcon)),
        leading: Padding(
          padding: EdgeInsetsGeometry.only(left: AppConstant.appPadding),
          child: CircleAvatar(),
        ),
        title: 'Local Share',
      ),
      body: const Center(child: Text('This is the Send Page')),

      floatingActionButton: FloatingActionButton.small(onPressed: () {}, child: Icon(AppIcon.addIcon),),
    );
  }
}
