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
      height: 70,
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
          unselectedItemColor: Theme.of(context).splashColor,
          elevation: 0,
          iconSize: 26,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 15),
                child: ImageIcon(
                  AssetImage('assets/images/Icon/Vector home.png'),
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 15),
                child: ImageIcon(
                  AssetImage('assets/images/Icon/Vector search.png'),
                ),
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 15),
                child: ImageIcon(
                  AssetImage('assets/images/Icon/explore.png'),
                ),
              ),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.only(top: 15),
                child: ImageIcon(
                  AssetImage('assets/images/Icon/Profiel.png'),
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
