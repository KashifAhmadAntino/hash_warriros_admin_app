import 'package:election_admin_panel/config/routes/app_routes.dart';
import 'package:election_admin_panel/feature/dashboard/dashboard.dart';
import 'package:election_admin_panel/feature/home/home_page.dart';
import 'package:election_admin_panel/feature/login/login_page.dart';
import 'package:election_admin_panel/feature/sign-up/sign_up.dart';
import 'package:flutter/material.dart';

class Navigation {
  static Route<dynamic>? onGenerateRoutes(RouteSettings routeSettings) {
    final arguments = routeSettings.arguments;
    switch (routeSettings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case AppRoutes.signUp:
        return MaterialPageRoute(builder: (context) => const SignUpPage());
      case AppRoutes.dashboard:
        return MaterialPageRoute(builder: (context) => const DashBoard());
      default:
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
                  body: Text("Error Page"),
                ));
    }
  }
}
