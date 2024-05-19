import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/extensions/extensions.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: SafeArea(
        child: GridView.builder(
          itemCount: 10,
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(color: TodoAppThemeData.gray, borderRadius: BorderRadius.circular(8)),
            ).toShimmer();
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 180,
      backgroundColor: TodoAppThemeData.basePrimary,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: Row(
        children: [
          16.horizontalSpace,
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Amazing Journey!',
                style: context.textTheme.headlineMedium?.copyWith(color: Colors.white),
              ),
              4.verticalSpace,
              Text(
                'You have successfully\nfinished 0 notes',
                style: context.textTheme.titleSmall?.copyWith(color: Colors.white),
                maxLines: 2,
                textAlign: TextAlign.start,
              ),
            ],
          ),
          Expanded(
            child: SvgPicture.asset(AppAssets.journey, alignment: Alignment.bottomCenter),
          ),
        ],
      ),
    );
  }
}
