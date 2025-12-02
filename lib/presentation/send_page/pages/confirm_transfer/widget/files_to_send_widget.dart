import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:local_share/widgets/picked_file_card.dart';

class FilesToSendWidget extends StatelessWidget {
  const FilesToSendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: EdgeInsetsGeometry.all(AppConstant.appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Files to Send (3)', style: theme.textTheme.titleMedium,),
              PickedFileCard(),
              PickedFileCard(),
              PickedFileCard(),
              PickedFileCard(),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Size', style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.onSecondary
                  ),),
                  Text('149.66 MB', style: theme.textTheme.titleMedium,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
