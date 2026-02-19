import 'package:flutter/material.dart';
import 'package:movie_app/auth/screens/register/register_screen.dart';
import 'package:movie_app/auth/screens/reset_password/reset_password_screen.dart';
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
  static const String onBoardingScreen = '/startScreen';
  static const String createWatchLists = '/createWatchLists';
  static const String discoverMovies = '/discoverMovies';
  static const String exploreAllGenre = '/exploreAllGenre';
  static const String rateAndReview = '/rateAndReview';
  static const String startWatchingNow = '/startWatchingNow';
  static const String resetPassword = '/resetPassword';
  static const String registerScreen = '/registerScreen';
  static const String updateProfileScreen = '/updateProfileScreen';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    Route<dynamic> darkRoute(Widget page) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return Container(
            color: AppColors.primaryBlack,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      );
    }

    switch (settings.name) {
      ///Cases of Onboarding Screens
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

      ///Home Screens
      case home:
        return darkRoute(
          const Scaffold(body: Center(child: Text('Home Screen'))),
        );
      case updateProfileScreen:
        return darkRoute(
          const UpdateProfileScreen(),
        );

      ///Auth Screens
      case resetPassword:
        return darkRoute(
          const ResetPasswordScreen(),
        );
      case registerScreen:
        return darkRoute(
          const RegisterScreen(),
        );
      default:
        return darkRoute(
          const Scaffold(body: Center(child: Text('No Route Defined'))),
        );
    }
  }
}
