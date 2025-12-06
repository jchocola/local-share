import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/core/icons/app_icon.dart';
import 'package:local_share/widgets/big_button.dart';

class ServerInfoCard extends StatelessWidget {
  const ServerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          children: [
            Text('Server' , style: theme.textTheme.titleLarge,),
            _customInfo(context, title: 'IP Address', value: '1.0.0.4'),
            _customInfo(context, title: 'Port', value: '8303'),
            BigButton(
              title: '',
              icon: AppIcon.onOffIcon,
              textColor: theme.colorScheme.error,
              color: theme.colorScheme.error.withOpacity(0.2),
              withIcon: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customInfo(
    BuildContext context, {
    String title = 'title',
    String value = 'value',
  }) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title, style: theme.textTheme.titleMedium,), Text(value , style: theme.textTheme.bodyMedium,)],
    );
  }
}
