import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({super.key , this.value = false , this.onChanged});
  final bool value;
  final void Function(bool)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(scale: 0.7, child: Switch(value: value, onChanged: onChanged));
  }
}
