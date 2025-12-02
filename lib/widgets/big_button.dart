import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    this.title = 'Title',
    this.onTap,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.withIcon = false,
    this.icon = Icons.add
  });

  final Color color;
  final Color textColor;
  final String title;
  final bool withIcon;
  final IconData icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstant.appBorder),
          color: color,
        ),
        padding: EdgeInsets.all(AppConstant.appPadding),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: AppConstant.appPadding,
            children: [
              withIcon ? Icon(icon, color: textColor,) : SizedBox(),
              Text(
                title,
                style: theme.textTheme.titleMedium!.copyWith(color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
