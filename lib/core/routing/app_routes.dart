import 'package:flutter/material.dart';
import '../../onBoarding/screens/start_screen/find_your_next_movie.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String onBoardingScreen = '/startScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const FindYourNextMovie(),
        );

      case home:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('Home Screen'))),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              const Scaffold(body: Center(child: Text('No Route Defined'))),
        );
    }
  }
}
