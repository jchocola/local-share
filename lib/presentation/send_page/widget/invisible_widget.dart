import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/error/app_error.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/core/utils/show_toastification.dart';
import 'package:local_share/generated/l10n.dart';
import 'package:local_share/presentation/receive_page/bloc/receive_page_bloc.dart';
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
              S.of(context).youAreInvisibleToOtherDevices,
              style: theme.textTheme.titleMedium,
            ),
            Text(
              S.of(context).turnOnVisibilityToAllowOtherDevicesToDiscoverAnd,
              style: theme.textTheme.bodyMedium!.copyWith(),
              textAlign: TextAlign.center,
            ),
            BlocListener<ReceivePageBloc, ReceivePageBlocState>(
              listener: (context, state) {
                if (state is ReceivePageBlocState_error) {
                  showErrorToatification(context , title: AppErrorConverter(error: state.error));
                }
              },

              child: BigButton(
                title: S.of(context).becomeVisible,
                color: theme.colorScheme.primary,
                textColor: theme.colorScheme.onPrimaryContainer,
                onTap: () => context.read<ReceivePageBloc>().add(
                  RecievePageBlocEvent_ChangeVisiblity(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
