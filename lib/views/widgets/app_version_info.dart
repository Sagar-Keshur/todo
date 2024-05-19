import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/themes/theme.dart';

class AppVersionInfo extends StatelessWidget {
  const AppVersionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.only(bottom: 40),
      child: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              'Makarya Notes v${snapshot.data?.buildNumber}',
              style: context.textTheme.labelSmall?.copyWith(color: TodoAppThemeData.greyColor, fontSize: 12),
              textAlign: TextAlign.center,
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
