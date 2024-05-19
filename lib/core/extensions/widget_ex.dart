import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/themes/theme.dart';

extension WidgetEx on Widget {
  Widget applyAlign(
    Alignment alignment, {
    bool animated = false,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    if (animated) {
      return AnimatedAlign(alignment: alignment, duration: duration, child: this);
    } else {
      return Align(alignment: alignment, child: this);
    }
  }

  PreferredSize applyPreferredSize({required Size preferredSize}) {
    return PreferredSize(preferredSize: preferredSize, child: this);
  }

  Widget toCenter() => Center(child: this);

  Widget applySafeArea({bool left = true, bool top = true, bool right = true, bool bottom = true}) {
    return SafeArea(left: left, top: top, right: right, bottom: bottom, child: this);
  }

  Widget applyExpanded({bool expanded = true}) {
    return expanded ? Expanded(child: this) : this;
  }

  Widget applyPaddingAll([double? value]) {
    return Padding(padding: EdgeInsets.all(value ?? defaultPaddingValue), child: this);
  }

  Widget applyPaddingHorizontal([double? horizontal]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? defaultPaddingValue),
      child: this,
    );
  }

  Widget applyPaddingVertical([double? vertical]) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: vertical ?? defaultPaddingValue),
      child: this,
    );
  }

  Widget toShimmer() {
    return Shimmer.fromColors(
      baseColor: TodoAppThemeData.darkGray.withOpacity(0.2),
      highlightColor: TodoAppThemeData.darkGray.withOpacity(0.1),
      child: this,
    );
  }
}
