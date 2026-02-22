import 'package:flutter/material.dart';
import 'bottom_nav.dart';
import '../../../profile_tab/profile/profile_screen.dart';
import 'fragments/home_fragment.dart';
import 'fragments/explore_fragment.dart';
import 'fragments/search_fragment.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeFragment(),
    const SearchFragment(),
    const ExploreFragment(),
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
