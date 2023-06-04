import 'package:flutter/material.dart';
import 'package:lastfm_app/api/user_requests.dart';
import 'package:lastfm_app/api/friend_requests.dart';
import 'package:lastfm_app/screens/user_profile_screen.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;
  final bool isFriend;

  ProfilePage({required this.name, required this.email, required this.isFriend});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<String> friendList = [];

  @override
  void initState() {
    super.initState();
    if (widget.isFriend) {
      _fetchFriendList();
    }
  }

  void _fetchFriendList() async {
    try {
      final friendsData = await UserAPI.fetchFriends();
      setState(() {
        friendList = friendsData;
      });
    } catch (error) {
      _showErrorDialog('Error occurred while fetching friend list.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addFriend() async {
    try {
      await FriendRequest.makeFriend(widget.email);

      // Refresh the profile
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => (ProfileScreen())
        )
      );
    } catch (error) {
      _showErrorDialog('Failed to add friend: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${widget.name}',
              style: TextStyle(fontSize: 20.0, color: Colors.blue),
            ),
            SizedBox(height: 10.0),
            if (widget.isFriend)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: ${widget.email}',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue),
                  ),
                  SizedBox(height: 20.0,),
                  Text(
                    'Friends:',
                    style: TextStyle(fontSize: 20.0, color: Colors.blue),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 200.0,
                    child: SingleChildScrollView(
                      child: Column(
                        children: friendList.map((friend) => Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            friend,
                            style: TextStyle(fontSize: 18.0, color: Colors.blue),
                          ),
                        )).toList(),
                      ),
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile is private',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: _addFriend, // Call the _addFriend method
                    child: Text('Become Friends'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
