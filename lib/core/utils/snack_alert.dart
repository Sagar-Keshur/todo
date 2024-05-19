import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/core/data/constants.dart';

enum _SnackAlertType { none, success, error }

const double _kElevation = 2;

const SnackBarBehavior _kSnackBarBehavior = SnackBarBehavior.floating;

const Duration _kDuration2000ms = Duration(milliseconds: 2000);

class SnackAlert {
  final BuildContext context;
  final String message;

  SnackAlert(this.context, this.message);

  void show() {
    var snackBar = _snackBar(_SnackAlertType.none);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void success() {
    var snackBar = _snackBar(_SnackAlertType.success);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void error() {
    var snackBar = _snackBar(_SnackAlertType.error);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showSnackBar(
    String message, {
    bool isBlack = true,
  }) {
    NavigatorState? state = defaultNavigatorKey.currentState;
    OverlayState? overlay = state?.overlay;
    if (overlay != null) {
      var snackBar = SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            color: isBlack ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isBlack ? Colors.black : Colors.white,
        behavior: _kSnackBarBehavior,
        elevation: _kElevation,
      );
      ScaffoldMessenger.of(overlay.context).showSnackBar(snackBar);
    }
  }

  SnackBar _snackBar(_SnackAlertType type) {
    Color color = Colors.black;

    switch (type) {
      case _SnackAlertType.none:
        color = Colors.black;
        break;
      case _SnackAlertType.success:
        color = Colors.green;
        break;
      case _SnackAlertType.error:
        color = Colors.red;
        break;
      default:
    }

    return SnackBar(
      content: Text(message),
      backgroundColor: color,
      behavior: _kSnackBarBehavior,
      duration: _kDuration2000ms,
      elevation: _kElevation,
    );
  }
}
