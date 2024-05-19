import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo/views/layouts/layouts.dart';

class ScrollableColumn extends SafeAreaStatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final bool isScrollable;
  final RefreshCallback? onRefresh;

  const ScrollableColumn({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
    this.isScrollable = true,
    this.onRefresh,
  }) : super(top: false, bottom: false, left: false, right: false);

  const ScrollableColumn.withSafeArea({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.primary,
    this.physics,
    this.controller,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.children,
    this.onRefresh,
    this.isScrollable = true,
    super.top = true,
    super.bottom = true,
    super.left = true,
    super.right = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget column = Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );

    Widget singleChildScrollView = SingleChildScrollView(
      padding: padding,
      physics: physics,
      primary: primary,
      reverse: reverse,
      controller: controller,
      clipBehavior: clipBehavior,
      restorationId: restorationId,
      scrollDirection: scrollDirection,
      dragStartBehavior: dragStartBehavior,
      keyboardDismissBehavior: keyboardDismissBehavior,
      child: column,
    );

    Widget child = isScrollable ? singleChildScrollView : Padding(padding: padding ?? EdgeInsets.zero, child: column);

    child = onRefresh != null
        ? RefreshIndicator(
            onRefresh: onRefresh!,
            child: child,
          )
        : child;

    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }
}
