import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/data/constants.dart';
import 'package:todo/core/data/app_options.dart';
import 'package:todo/core/data/firebase_options.dart';
import 'package:todo/core/extensions/build_context_ex.dart';
import 'package:todo/core/themes/theme.dart';
import 'package:todo/core/utils/preferences.dart';
import 'package:todo/routes.dart';
import 'package:todo/views/layouts/responsive_widget.dart';
import 'package:todo/views/layouts/restart_widget.dart';
import 'package:todo/views/pages/authentication/bloc/auth_bloc.dart';
import 'package:todo/views/pages/home/bloc/home_bloc.dart';
import 'package:todo/views/pages/onboarding/landing_page.dart';
import 'package:todo/views/pages/setting/bloc/profile_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const RestartWidget(child: MyApp()));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
        initialOptions: AppOptions(
          title: productName,
          textScaler: defaultTextScaler,
          themeMode: defaultThemeMode,
          platform: defaultTargetPlatform,
        ),
        child: Builder(
          builder: (context) {
            AppOptions options = context.options;
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => AuthBloc()),
                BlocProvider(create: (context) => ProfileBloc()),
                BlocProvider(create: (context) => HomeBloc()),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: options.title,
                navigatorKey: defaultNavigatorKey,
                themeMode: options.themeMode,
                theme: TodoAppThemeData.lightThemeData.copyWith(platform: options.platform),
                initialRoute: LandingPage.route,
                onGenerateRoute: RouteGenerator.generateRoute,
                builder: (context, child) {
                  return ResponsiveWidget(child: child ?? const SizedBox.shrink());
                },
              ),
            );
          },
        ));
  }
}
