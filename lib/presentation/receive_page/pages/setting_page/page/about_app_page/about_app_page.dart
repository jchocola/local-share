import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/generated/l10n.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).aboutApp)),
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppConstant.appPadding,
      children: [
        Expanded(
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppConstant.appPadding,
            children: [
              Center(
            child: Image.asset(
              'assets/share.png',
              width: AppConstant.bigIcon * 4,
            ),
          ),
          Gap(AppConstant.appPadding * 3),
          Text(S.of(context).localshare, style: theme.textTheme.titleLarge,),
           Text(S.of(context).appDescription, style: theme.textTheme.titleSmall,),
          
          Text(S.of(context).versionAppversion(AppConstant.appVersion), style: theme.textTheme.bodySmall,),
          Text(S.of(context).buildDateBuilddate(AppConstant.buildDate), style: theme.textTheme.bodySmall,),
           Text(S.of(context).developerDevelopername(AppConstant.developerName), style: theme.textTheme.bodySmall,),
            ],
          ),
        ),


       
        Text(AppConstant.copyrightText, style: theme.textTheme.bodySmall,),
         Text(AppConstant.allRightsReserved, style: theme.textTheme.bodySmall,), 

      ],
    );
  }
}
