import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/extensions/extensions.dart';
import 'package:todo/core/themes/theme.dart';

abstract class LoadingIndicatorDelegate<T> {
  void show();

  void hide();
}

class LoadingIndicator extends LoadingIndicatorDelegate<String> {
  LoadingIndicator._(this._context);

  final BuildContext _context;

  static LoadingIndicator get instance {
    BuildContext? context = defaultNavigatorKey.currentContext;
    if (context != null) {
      return LoadingIndicator._(context);
    }
    throw UnimplementedError();
  }

  @override
  void show() {
    showDialog(
      context: _context,
      barrierColor: Colors.white.withOpacity(0.3),
      barrierDismissible: kDebugMode,
      builder: (context) => loader(context),
    );
  }

  @override
  void hide() {
    Navigator.pop(_context);
  }

  static Widget loader(BuildContext context) {
    Color color = TodoAppThemeData.basePrimary;
    return CircularProgressIndicator(
      color: color,
      backgroundColor: color.withOpacity(0.2),
    ).toCenter();
  }
}
