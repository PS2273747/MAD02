import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lastfm_app/widgets/bottom_nav.dart';

class PopularSongsScreen extends StatefulWidget {
  const PopularSongsScreen({Key? key}) : super(key: key);

  @override
  State<PopularSongsScreen> createState() => _PopularSongsScreenState();
}

class _PopularSongsScreenState extends State<PopularSongsScreen> {
  List<dynamic> songs = [];

  @override
  void initState() {
    super.initState();
    fetchSongs(); // Fetch songs when the screen is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Songs'),
      ),
      body: ListView.builder(
        itemCount: songs.length,
        itemBuilder: (BuildContext context, int index) {
          final song = songs[index];
          final songName = song['name'];
          final artistName = song['artist']['name'];

          return ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(songName),
            subtitle: Text(artistName),
          );
        },
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 1,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/search');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/favorites');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchSongs, // Optional: Keep the refresh button
        child: Icon(Icons.refresh),
      ),
    );
  }

  void fetchSongs() async {
    print('fetchSongs Called');
    const url =
        'http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=6b4fe43c2ad4c5b83019e380ac5a61c1&format=json&limit=20';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      songs = json['tracks']['track'];
    });

    print('fetchSongs Completed');
  }
}
