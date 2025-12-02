import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/widgets/picked_file_card.dart';

class PickedFiles extends StatelessWidget {
  const PickedFiles({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: AppConstant.appPadding,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('3 Files', style: theme.textTheme.bodyMedium),
            Text('43 MB', style: theme.textTheme.titleMedium),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: List.generate(4, (index) => PickedFileCard(withFixedWidth: true,))),
        ),
      ],
    );
  }
}
