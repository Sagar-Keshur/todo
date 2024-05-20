import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo/core/data/app_assets.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/views/pages/home/view/add_note_page.dart';
import 'package:todo/views/pages/home/view/home_page.dart';
import 'package:todo/views/pages/setting/bloc/profile_bloc.dart';
import 'package:todo/views/pages/setting/view/setting_page.dart';

final ValueNotifier<int> index = ValueNotifier<int>(0);

class MainHomePage extends StatefulWidget {
  static const String route = '/main-home-page';

  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  late final ProfileBloc _profileBloc = context.read<ProfileBloc>();

  @override
  void initState() {
    super.initState();
    _profileBloc.getUserInfo();
  }

  @override
  void dispose() {
    _profileBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: index,
      builder: (BuildContext context, _, Widget? child) {
        Widget body;
        switch (index.value) {
          case 0:
            body = const HomePage();
            break;
          case 1:
            body = const SettingPage();
            break;
          default:
            body = const SizedBox();
        }

        return Scaffold(
          body: body,
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, AddNotePage.route),
            backgroundColor: TodoAppThemeData.basePrimary,
            child: SvgPicture.asset(AppAssets.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: index.value,
            onTap: (value) => index.value = value,
            items: [
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(AppAssets.homeActive),
                icon: SvgPicture.asset(AppAssets.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(AppAssets.settingActive),
                icon: SvgPicture.asset(AppAssets.setting),
                label: 'Setting',
              ),
            ],
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: TodoAppThemeData.basePrimary,
            unselectedItemColor: TodoAppThemeData.darkGray,
          ),
        );
      },
    );
  }
}
