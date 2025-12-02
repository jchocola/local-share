import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/presentation/send_page/bloc/send_page_bloc.dart';
import 'package:local_share/widgets/big_button.dart';

class InvisibleWidget extends StatelessWidget {
  const InvisibleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(AppIcon.closeEyeIcon, size: AppConstant.bigIcon),
            Text(
              'You are invisible to other devices',
              style: theme.textTheme.titleMedium,
            ),
            Text(
              'Turn on visibility to allow other devices to discover and send files to you',
              style: theme.textTheme.bodyMedium!.copyWith(),
              textAlign: TextAlign.center,
            ),
            BigButton(
              title: 'Become Visible',
              color: theme.colorScheme.primary,
              textColor: theme.colorScheme.onPrimaryContainer,
              onTap: () => context.read<SendPageBloc>().add(
                SendPageBlocEvent_ChangeVisiblity(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
