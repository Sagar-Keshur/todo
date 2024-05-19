import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';

class BackButtonAppBar extends PreferredSize {
  BackButtonAppBar(
    BuildContext context, {
    super.key,
    String? title,
    String backTitle = 'Back',
    VoidCallback? onBackPressed,
    SystemUiOverlayStyle systemOverlayStyle = SystemUiOverlayStyle.dark,
  }) : super(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: AppBar(
            shadowColor: const Color(0xFFEFEEF0),
            elevation: 0,
            systemOverlayStyle: systemOverlayStyle,
            leading: const SizedBox.shrink(),
            leadingWidth: 0,
            title: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: onBackPressed ?? () => Navigator.of(context).pop(),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppAssets.backArrow),
                        8.horizontalSpace,
                        Text(
                          backTitle,
                          style: context.textTheme.labelMedium?.copyWith(color: TodoAppThemeData.basePrimary),
                        ),
                      ],
                    ),
                  ),
                ),
                if (title != null)
                  Expanded(
                    flex: 2,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.labelMedium?.copyWith(color: Colors.black),
                    ),
                  ),
                const Expanded(flex: 1, child: SizedBox())
              ],
            ),
          ),
        );
}
