import 'package:flutter/material.dart';
import 'package:todo/views/pages/authentication/view/login_page.dart';
import 'package:todo/views/pages/authentication/view/register_page.dart';
import 'package:todo/views/pages/home/view/add_note_page.dart';
import 'package:todo/views/pages/main_home/main_home.dart';
import 'package:todo/views/pages/onboarding/landing_page.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LandingPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LandingPage(),
        );
      case LoginPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const LoginPage(),
        );

      case RegisterPage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const RegisterPage(),
        );
      case MainHomePage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const MainHomePage(),
        );
      case AddNotePage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const AddNotePage(),
        );

      default:
        return null;
    }
  }
}
