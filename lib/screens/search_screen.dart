import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lastfm_app/widgets/bottom_nav.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  final String apiKey = '6b4fe43c2ad4c5b83019e380ac5a61c1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for a song',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final query = _searchController.text;
                    if (query.isNotEmpty) {
                      await searchSongs(query);
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                final song = _searchResults[index];
                final songName = song['name'];
                final artistName = song['artist']['name'];

                return ListTile(
                  title: Text(songName),
                  subtitle: Text(artistName),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 2,
        onItemTapped: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/popular');
          } else if (index == 3) {
            Navigator.pushReplacementNamed(context, '/favorites');
          }
        },
      ),
    );
  }

  Future<void> searchSongs(String query) async {
    print('searchSongs Called');
    final url =
        'http://ws.audioscrobbler.com/2.0/?method=track.search&api_key=$apiKey&format=json&limit=20&track=$query';

    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);

    setState(() {
      _searchResults = json['results']['trackmatches']['track'] ?? [];
    });

    print('searchSongs Completed');
  }
}
