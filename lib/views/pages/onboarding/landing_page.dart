import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/views/layouts/scrollable_column.dart';
import 'package:todo/views/pages/authentication/view/login_page.dart';
import 'package:todo/views/pages/main_home/main_home.dart';
import 'package:todo/views/widgets/app_primary_button.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  static const String route = '/landing';

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();

    if (preferences.isLogged) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacementNamed(context, MainHomePage.route);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(systemOverlayStyle: SystemUiOverlayStyle.light),
      backgroundColor: TodoAppThemeData.basePrimary,
      body: ScrollableColumn.withSafeArea(
        padding: const EdgeInsets.all(16),
        children: [
          86.verticalSpace,
          SvgPicture.asset(AppAssets.landing),
          24.verticalSpace,
          Text(
            'Note Down anything you want to achieve, today or in the future',
            style: context.textTheme.headlineMedium?.copyWith(fontSize: 20, color: Colors.white),
          ),
          158.verticalSpace,
          AppPrimaryButton.white(
            label: 'Let’s Get Started',
            onPressed: () async => Navigator.pushReplacementNamed(context, LoginPage.route),
          ),
        ],
      ),
    );
  }
}
