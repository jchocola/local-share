import 'package:flutter/material.dart';
import 'package:local_share/core/constant/app_constant.dart';
import 'package:shimmer_progress_bar/shimmer_progress_bar.dart';

class CustomLinearProgressBar extends StatelessWidget {
  const CustomLinearProgressBar({super.key, this.showPercentage = false , this.height = 14});
  final bool showPercentage;
  final double height;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ShimmerProgressBar(
      value: 0.65, // 65%
      height: height,
      valueColor: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.onSecondary.withOpacity(0.3),
      shimmerColor: Colors.white.withOpacity(0.3),
      showShimmer: true,
      showPercentage: showPercentage,
      alignPercentageToTip: false,
      semanticsLabel: 'Loading progress',
    );
  }
}
