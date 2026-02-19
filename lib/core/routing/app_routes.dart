import 'package:flutter/material.dart';
import 'package:movie_app/auth/screens/Register.dart';
import 'package:movie_app/auth/screens/reset_password_screen.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/create_watchlists.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/discover_movies_screen.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/explore_all_genres.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/rate_review_and_learn.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/start_watching_now.dart';
import 'package:movie_app/profile_screen/update_profile_screen.dart';
import '../../onBoarding/screens/start_screen/find_your_next_movie.dart';
import '../colors/app_colors.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String register = '/register'; // إضافة مسار الـ Register
  static const String onBoardingScreen = '/startScreen';
  static const String createWatchLists = '/createWatchLists';
  static const String discoverMovies = '/discoverMovies';
  static const String exploreAllGenre = '/exploreAllGenre';
  static const String rateAndReview = '/rateAndReview';
  static const String startWatchingNow = '/startWatchingNow';
<<<<<<< HEAD
  static const String upDateProfile = '/UpdateProfileScreen';
=======
  static const String resetPassword = '/resetPassword';
>>>>>>> origin/develop

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {

    Route<dynamic> darkRoute(Widget page) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // This Container ensures the background is ALWAYS dark during the slide/fade
          return Container(
            color: AppColors.primaryBlack,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      );
    }

    switch (settings.name) {

    /// Auth Screens
      case register: // إضافة الـ Case الخاصة بالـ Register
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );
      case upDateProfile:
        return MaterialPageRoute(
          builder: (context) => UpdateProfileScreen(),
        );

      case resetPassword:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );

    /// Cases of Onboarding Screens
      case onBoardingScreen:
        return darkRoute(
          const FindYourNextMovie(),
        );
      case createWatchLists:
        return darkRoute(
          const CreateWatchLists(),
        );
      case discoverMovies:
        return darkRoute(
          const DiscoverMoviesScreen(),
        );
      case exploreAllGenre:
        return darkRoute(
          const ExploreAllGenres(),
        );
      case rateAndReview:
        return darkRoute(
          const RateReviewAndLearn(),
        );
      case startWatchingNow:
        return darkRoute(
          const StartWatchingNow(),
        );

    /// Home Screens
      case home:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(body: Center(child: Text('Home Screen'))),
      ///Home Screens
      case home:
        return darkRoute(
          const Scaffold(body: Center(child: Text('Home Screen'))),
        );

      ///Auth Screens
      case resetPassword:
        return darkRoute(
          const ResetPasswordScreen(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>
        return darkRoute(
          const Scaffold(body: Center(child: Text('No Route Defined'))),
        );
    }
  }
}