import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';

class StartYourJourneyView extends StatelessWidget {
  const StartYourJourneyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.background,
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 61),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(AppAssets.homeBg),
              24.verticalSpace,
              Text(
                'Start Your Journey',
                style: context.textTheme.headlineMedium?.copyWith(color: TodoAppThemeData.blackColor, fontSize: 24),
              ),
              16.verticalSpace,
              Text(
                'Every big step start with small step.\nNotes your first idea and start\nyour journey!',
                style: context.textTheme.titleSmall,
                textAlign: TextAlign.center,
                maxLines: 3,
              ),
              21.verticalSpace,
              SvgPicture.asset(AppAssets.arrow),
              40.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
