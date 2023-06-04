import 'package:flutter/material.dart';
import 'package:lastfm_app/screens/profile_screen.dart';
import 'package:lastfm_app/api/user_requests.dart';

class ResultPage extends StatelessWidget {
  final List<Map<String, String>> userList;

  ResultPage({required this.userList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final name = userList[index]['name'] ?? '';
          final userEmail = userList[index]['email'] ?? '';

          return ListTile(
            title: Text(name),
            //subtitle: Text(userEmail), // Display the email in the subtitle for testing purposes
            onTap: () async {
              if (userEmail.isNotEmpty) {
                final isFriend = await checkIfFriends(userEmail);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      name: name,
                      email: userEmail,
                      isFriend: isFriend,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<bool> checkIfFriends(String userEmail) async {
    try {
      final isFriend = await UserAPI.checkFriendshipStatus(userEmail);
      return isFriend;
    } catch (error) {
      print('Failed to check friendship status: $error');
      return false;
    }
  }
}
