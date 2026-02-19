import 'package:flutter/material.dart';
import 'package:movie_app/auth/screens/reset_password_screen.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/create_watchlists.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/discover_movies_screen.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/explore_all_genres.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/rate_review_and_learn.dart';
import 'package:movie_app/onBoarding/screens/on_boarding_screens/start_watching_now.dart';
import '../../onBoarding/screens/start_screen/find_your_next_movie.dart';
import '../colors/app_colors.dart';
import '../../profile/profile_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String login = '/login';
  static const String onBoardingScreen = '/startScreen';
  static const String createWatchLists = '/createWatchLists';
  static const String discoverMovies = '/discoverMovies';
  static const String exploreAllGenre = '/exploreAllGenre';
  static const String rateAndReview = '/rateAndReview';
  static const String startWatchingNow = '/startWatchingNow';
  static const String resetPassword = '/resetPassword';
  static const String registerScreen = '/registerScreen';
  static const String profile = '/profile';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
    ///Cases of Onboarding Screens
      case onBoardingScreen:
        return MaterialPageRoute(
          builder: (context) => const FindYourNextMovie(),
        );
      case createWatchLists:
        return MaterialPageRoute(
          builder: (context) => const CreateWatchLists(),
        );
      case discoverMovies:
        return MaterialPageRoute(
          builder: (context) => const DiscoverMoviesScreen(),
        );
      case exploreAllGenre:
        return MaterialPageRoute(
          builder: (context) => const ExploreAllGenres(),
        );
      case rateAndReview:
        return MaterialPageRoute(
          builder: (context) => const RateReviewAndLearn(),
        );
      case startWatchingNow:
        return MaterialPageRoute(
          builder: (context) => const StartWatchingNow(),
        );

    ///Home Screens
      case home:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(body: Center(child: Text('Home Screen'))),
        );
    ///Auth Screens
      case resetPassword:
        return MaterialPageRoute(
          builder: (context) => const ResetPasswordScreen(),
        );
    ///Profile Screens
      case profile:
        return MaterialPageRoute(
          builder: (context) => const ProfileScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(body: Center(child: Text('No Route Defined'))),
        );
    }
  }
}