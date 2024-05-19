import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/extensions/num_ext.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/views/layouts/restart_widget.dart';
import 'package:todo/views/pages/authentication/bloc/auth_bloc.dart';
import 'package:todo/views/pages/main_home/main_home.dart';
import 'package:todo/views/pages/onboarding/landing_page.dart';
import 'package:todo/views/pages/setting/bloc/profile_bloc.dart';
import 'package:todo/views/pages/setting/view/logout_dialog.dart';
import 'package:todo/views/widgets/app_bars.dart';
import 'package:todo/views/widgets/app_version_info.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late final AuthBloc _authBloc = context.read<AuthBloc>();
  late final ProfileBloc _profileBloc = context.read<ProfileBloc>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(
        context,
        title: 'Setting',
        onBackPressed: () => index.value = 0,
      ),
      bottomNavigationBar: const AppVersionInfo(),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        listener: (BuildContext context, ProfileState state) {
          if (state.accountNotExists) {
            _authBloc.signOut().whenComplete(() {
              Navigator.pushNamedAndRemoveUntil(
                context,
                LandingPage.route,
                (route) => false,
              );
              RestartWidget.restartApp(context);
            });
          }
        },
        builder: (BuildContext context, state) => buildBody(context, state),
      ),
    );
  }

  Widget buildBody(BuildContext context, ProfileState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPaddingValue, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.userInfo?.name ?? 'N/A',
            style: context.textTheme.headlineMedium,
          ),
          8.verticalSpace,
          Row(
            children: [
              SvgPicture.asset(AppAssets.mail),
              8.horizontalSpace,
              Text(
                state.userInfo?.email ?? 'N/A',
                style: context.textTheme.titleSmall?.copyWith(color: TodoAppThemeData.blackColor),
              ),
            ],
          ),
          24.verticalSpace,
          const Divider(thickness: 1, height: 1),
          25.verticalSpace,
          GestureDetector(
            onTap: () async {
              bool isLogout = await showDialog(
                context: context,
                barrierColor: const Color(0xFF180E25).withOpacity(0.4),
                barrierDismissible: false,
                builder: (context) => const LogoutDialog(),
              );
              if (isLogout) {
                await _authBloc.signOut().whenComplete(() {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    LandingPage.route,
                    (route) => false,
                  );
                });
              }
            },
            child: Row(
              children: [
                SvgPicture.asset(AppAssets.logout),
                12.horizontalSpace,
                Text(
                  'Log Out',
                  style: context.textTheme.labelMedium?.copyWith(color: TodoAppThemeData.baseError),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
