import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> bottomNavBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.restaurant_menu),
        label: 'Recipes',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.star),
        label: 'TBD',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        label: 'TBD',
      ),
    ];

    return BottomNavigationBar(
      items: bottomNavBarItems,
      currentIndex: currentIndex,
      onTap: onTap,
    );
  }
}
