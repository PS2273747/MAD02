import 'package:flutter/material.dart';
import 'package:lastfm_app/screens/profile_screen.dart';
import 'package:lastfm_app/screens/popular_songs_screen.dart';
import 'package:lastfm_app/screens/search_screen.dart';
import 'package:lastfm_app/screens/favorite_songs_screen.dart';
import 'package:lastfm_app/screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Last.fm App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/profile': (context) => ProfileScreen(),
        '/popular': (context) => PopularSongsScreen(),
        '/search': (context) => SearchScreen(),
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
