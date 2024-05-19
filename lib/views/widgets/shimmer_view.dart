import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo/core/extensions/build_context_ex.dart';

class ShimmerView extends StatelessWidget {
  final Widget child;
  final Color? effectColor;

  const ShimmerView({
    super.key,
    required this.child,
    this.effectColor,
  });

  @override
  Widget build(BuildContext context) {
    Color effectColor = this.effectColor ?? context.colorScheme.secondary;

    return Shimmer.fromColors(
      baseColor: effectColor.withOpacity(0.2),
      highlightColor: effectColor.withOpacity(0.1),
      child: child,
    );
  }
}
