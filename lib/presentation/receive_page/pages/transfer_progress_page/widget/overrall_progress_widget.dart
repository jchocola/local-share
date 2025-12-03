import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/widgets/custom_linear_progress_bar.dart';
import 'package:shimmer_progress_bar/shimmer_progress_bar.dart';

class OverrallProgressWidget extends StatelessWidget {
  const OverrallProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
        child: Column(
          spacing: AppConstant.appPadding,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Overall Progress', style: theme.textTheme.titleMedium,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text('Progress',style: theme.textTheme.bodySmall), Text('65%' , style: theme.textTheme.titleMedium!.copyWith(
                color: theme.colorScheme.primary
              ),)],
            ),

           CustomLinearProgressBar(),

            Gap(AppConstant.appPadding * 2),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: _customButton(context, title: 'Speed', value: 'Speed'),
                ),
                Expanded(flex: 1, child: _customButton(context, title: 'Time Left', value: '45s')),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _customButton(
    BuildContext context, {
    String title = 'Title',
    String value = 'value',
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title, style: theme.textTheme.bodySmall),
        Text(value, style: theme.textTheme.titleMedium),
      ],
    );
  }
}
