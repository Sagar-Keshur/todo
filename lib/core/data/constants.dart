import 'package:flutter/material.dart';
import 'package:todo/core/utils/preferences.dart';

final Preferences preferences = Preferences.instance;

TextScaler get defaultTextScaler => TextScaler.noScaling;

ThemeMode get defaultThemeMode => ThemeMode.light;

String get productName => 'Todo App';

double get defaultPaddingValue => 15;
double get defaultSpaceValue => 20;

double get defaultRadiusValue => 12;

double get defaultLetterSpacing => 0.8;

GlobalKey<NavigatorState> defaultNavigatorKey = GlobalKey<NavigatorState>();
