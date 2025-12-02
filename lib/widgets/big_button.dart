import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';

class BigButton extends StatelessWidget {
  const BigButton({super.key, this.title = 'Title', this.onTap});

  final String title;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.appBorder),
          color: theme.colorScheme.primary,
        ),
        padding: EdgeInsets.all(AppConstant.appPadding),
        child: Center(
          child: Text(
            title,
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
