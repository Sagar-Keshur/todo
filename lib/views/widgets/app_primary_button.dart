import 'package:flutter/material.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';

class AppPrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double height;

  final Color backgroundColor;
  final Color textColor;
  final bool isOutline;
  final bool icon;

  const AppPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 55,
    this.icon = true,
  })  : backgroundColor = TodoAppThemeData.basePrimary,
        textColor = TodoAppThemeData.whiteColor,
        isOutline = false;

  const AppPrimaryButton.white({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 55,
    this.icon = true,
  })  : backgroundColor = TodoAppThemeData.whiteColor,
        textColor = TodoAppThemeData.basePrimary,
        isOutline = false;

  const AppPrimaryButton.outline({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 55,
    this.icon = false,
  })  : backgroundColor = TodoAppThemeData.whiteColor,
        textColor = TodoAppThemeData.basePrimary,
        isOutline = true;

  @override
  Widget build(BuildContext context) {
    BorderRadius radius = BorderRadius.circular(100);

    Text text = Text(
      label,
      textAlign: TextAlign.center,
      style: context.textTheme.labelMedium?.copyWith(
        color: textColor,
        letterSpacing: defaultLetterSpacing,
      ),
    );

    Widget child;

    if (icon) {
      child = Container(
        height: height,
        decoration: BoxDecoration(borderRadius: radius, color: backgroundColor),
        child: Row(
          children: [
            16.horizontalSpace,
            Visibility(visible: false, child: Icon(Icons.arrow_forward, color: textColor)),
            Expanded(child: text),
            Icon(Icons.arrow_forward, color: textColor),
            16.horizontalSpace,
          ],
        ),
      );
    } else if (isOutline) {
      child = Container(
        height: height,
        decoration: BoxDecoration(borderRadius: radius, color: backgroundColor, border: Border.all(color: textColor, width: 1)),
        alignment: Alignment.center,
        child: text,
      );
    } else {
      child = Container(
        height: height,
        decoration: BoxDecoration(borderRadius: radius, color: backgroundColor),
        alignment: Alignment.center,
        child: text,
      );
    }

    return InkWell(onTap: onPressed, borderRadius: radius, child: child);
  }
}
