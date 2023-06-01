import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const BottomNav({
    required this.currentIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.blue, // Set the background color to blue
      selectedItemColor: Colors.blue, // Set the selected icon color to white
      unselectedItemColor: Colors.grey.withOpacity(0.6), // Set the unselected icon color to a slightly transparent white
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == currentIndex) {
          return;
        }
        //routes can be found in main.dart
        switch (index) {
          case 0:
            Navigator.pushReplacementNamed(context, '/');
            break;
          case 1:
            Navigator.pushReplacementNamed(context, '/popular');
            break;
          case 2:
            Navigator.pushReplacementNamed(context, '/search');
            break;
          case 3:
            Navigator.pushReplacementNamed(context, '/favorites');
            break;
        }

        onItemTapped(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.whatshot),
          label: 'Popular Songs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Favorites',
        ),
      ],
    );
  }
}
