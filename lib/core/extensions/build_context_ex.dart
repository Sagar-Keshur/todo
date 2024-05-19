import 'package:flutter/material.dart';
import 'package:todo/core/data/app_options.dart';

extension BuildContextEx on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  ThemeData get theme => Theme.of(this);

  AppOptions get options => AppOptions.of(this);

  double get width => mediaQuery.size.width;

  double get height => mediaQuery.size.height;

  ColorScheme get colorScheme => theme.colorScheme;

  TextTheme get textTheme => theme.textTheme;
}
