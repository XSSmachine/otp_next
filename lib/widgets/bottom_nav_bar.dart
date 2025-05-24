import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Početna',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Plaćanja',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book),
          label: 'Proizvodi',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu),
          label: 'Više',
        ),
      ],
    );
  }
} 