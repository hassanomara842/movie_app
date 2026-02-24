import 'package:flutter/material.dart';
import 'package:movie_app/home_screen/tabes/explore_tab.dart';
import 'package:movie_app/home_screen/tabes/home_tab.dart';
import 'package:movie_app/home_screen/tabes/search_tab.dart';
import 'bottom_nav.dart';
import '../profile_tab/profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(),
    const SearchTab(),
    const ExploreTab(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
