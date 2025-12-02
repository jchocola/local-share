import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  const Appbar({
    super.key,
    this.title = 'Local Share',
    this.withLeading = false,
    this.withTrailing = false,
    this.leading,
    this.trailing,
  });
  final String title;
  final bool withLeading;
  final Widget? leading;
  final bool withTrailing;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: withLeading ? leading : null,
      actions: withTrailing ? [
        if (trailing != null) trailing!,
      ] : null,
      title: Text(title),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
