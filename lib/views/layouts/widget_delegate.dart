import 'package:flutter/material.dart';

typedef WidgetDelegateBuilder = Widget Function();

class WidgetDelegate extends StatelessWidget {
  final bool shouldShowPrimary;
  final WidgetDelegateBuilder primaryWidget;
  final WidgetDelegateBuilder alternateWidget;

  const WidgetDelegate({
    super.key,
    this.shouldShowPrimary = true,
    required this.primaryWidget,
    required this.alternateWidget,
  });

  @override
  Widget build(BuildContext context) {
    return shouldShowPrimary ? primaryWidget() : alternateWidget();
  }
}
