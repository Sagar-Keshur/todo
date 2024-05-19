import 'package:flutter/material.dart';

abstract class AppLifecycleStateHandler {
  void didChangeAppLifecycleState(AppLifecycleState state);
}

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;
  final AppLifecycleStateHandler handler;

  const AppLifecycleObserver(
      {super.key, required this.handler, required this.child});

  @override
  AppLifecycleObserverState createState() => AppLifecycleObserverState();
}

class AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    widget.handler.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
