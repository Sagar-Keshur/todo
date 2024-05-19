import 'package:flutter/material.dart';

extension NumEx on num {
  SizedBox get verticalSpace => SizedBox(height: toDouble());

  SizedBox get horizontalSpace => SizedBox(width: toDouble());
}
