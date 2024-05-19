import 'package:flutter/material.dart';

export 'dismiss_focus_overlay.dart';
export 'restart_widget.dart';
export 'responsive_widget.dart';
export 'scrollable_column.dart';
export 'app_lifecycle_observer.dart';
export 'widget_delegate.dart';

abstract class SafeAreaStatelessWidget extends StatelessWidget {
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  const SafeAreaStatelessWidget({
    super.key,
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  });
}
