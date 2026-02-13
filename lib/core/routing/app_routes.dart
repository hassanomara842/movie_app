import 'package:flutter/material.dart';
class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('Home Screen')),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(child: Text('No Route Defined')),
          ),
        );
    }
  }
}