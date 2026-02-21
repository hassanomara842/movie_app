import 'package:flutter/material.dart';
import 'package:movie_app/core/colors/app_colors.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 70, // Slightly more height to accommodate the icons without overflow
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTap,
          backgroundColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryYellow,
          unselectedItemColor: Theme.of(context).splashColor.withOpacity(0.6),
          elevation: 0,
          iconSize: 26, // Slightly smaller icons to fit perfectly
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0, // Ensure no space is reserved for labels
          unselectedFontSize: 0, // Ensure no space is reserved for labels
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
