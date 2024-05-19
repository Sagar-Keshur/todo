import 'package:flutter/material.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/views/widgets/app_primary_button.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.center,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultPaddingValue)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Log Out',
              style: context.textTheme.headlineMedium?.copyWith(color: TodoAppThemeData.blackColor),
            ),
            8.verticalSpace,
            Text(
              'Are you sure you want to log out from the application?',
              style: context.textTheme.titleSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            48.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppPrimaryButton.outline(
                    label: 'Cancel',
                    onPressed: () => Navigator.pop(context, false),
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: AppPrimaryButton(
                    label: 'Yes',
                    onPressed: () => Navigator.pop(context, true),
                    icon: false,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
