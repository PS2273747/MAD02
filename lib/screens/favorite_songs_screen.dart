import 'package:flutter/material.dart';
import 'package:lastfm_app/widgets/bottom_nav.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: const Center(
        child: Text('Your favorite songs will appear here.'),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 3,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/popular');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/search');
          }
        },
      ),
    );
  }
}
