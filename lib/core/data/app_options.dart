import 'package:flutter/material.dart';

class AppOptions {
  final ThemeMode themeMode;
  final TextScaler textScaler;
  final TargetPlatform? platform;
  final String title;

  const AppOptions({
    required this.themeMode,
    required this.textScaler,
    required this.platform,
    required this.title,
  });

  AppOptions copyWith({
    ThemeMode? themeMode,
    TextScaler? textScaler,
    TargetPlatform? platform,
    String? title,
  }) {
    return AppOptions(
      themeMode: themeMode ?? this.themeMode,
      textScaler: textScaler ?? this.textScaler,
      platform: platform ?? this.platform,
      title: title ?? this.title,
    );
  }

  static AppOptions of(BuildContext context) {
    final _ModelBindingScope scope = context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    return scope.modelBindingState.options;
  }

  static void update(BuildContext context, AppOptions newData) {
    final _ModelBindingScope scope = context.dependOnInheritedWidgetOfExactType<_ModelBindingScope>()!;
    scope.modelBindingState.updateOptions(newData);
  }

  @override
  bool operator ==(Object other) {
    return other is AppOptions && themeMode == other.themeMode && textScaler == other.textScaler && platform == other.platform && title == other.title;
  }

  @override
  int get hashCode {
    return Object.hash(themeMode, textScaler, title, platform);
  }
}

class _ModelBindingScope extends InheritedWidget {
  const _ModelBindingScope({
    required this.modelBindingState,
    required super.child,
  });

  final _ModelBindingState modelBindingState;

  @override
  bool updateShouldNotify(_ModelBindingScope oldWidget) => true;
}

class ModelBinding extends StatefulWidget {
  const ModelBinding({
    super.key,
    required this.initialOptions,
    required this.child,
  });

  final AppOptions initialOptions;
  final Widget child;

  @override
  State<ModelBinding> createState() => _ModelBindingState();
}

class _ModelBindingState extends State<ModelBinding> {
  late AppOptions options;

  @override
  void initState() {
    super.initState();
    options = widget.initialOptions;
  }

  void updateOptions(AppOptions newOptions) {
    if (newOptions != options) {
      setState(() {
        options = newOptions;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ModelBindingScope(modelBindingState: this, child: widget.child);
  }
}
