import 'package:flutter/material.dart';
import 'package:lastfm_app/api/user_requests.dart';
import 'package:lastfm_app/api/user_data.dart';
import 'package:lastfm_app/widgets/bottom_nav.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  String _email = '';
  List<String> _friends = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final userData = await UserAPI.fetchUser();
      final friendsData = await UserAPI.fetchFriends();

      setState(() {
        _name = userData['name'];
        _email = userData['email'];
        _friends = friendsData;
      });
    } catch (error) {
      _showErrorDialog('Error occurred while fetching user data.');
    }
  }

  void _performLogout() async {
    try {
      final authToken = UserData.authToken ?? '';
      await UserAPI.logout(authToken);
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      _showErrorDialog('Error occurred while logging out.');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              _name,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 20.0),
            Text(
              'Email:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Text(
              _email,
              style: TextStyle(fontSize: 24.0),
            ),
            SizedBox(height: 30.0),
            Text(
              'Friends:',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),
            Column(
              children: _friends.map((friend) => Text(friend)).toList(),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _performLogout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
        onItemTapped: (index) {
          // No navigation logic here, handled in BottomNav widget
        },
      ),
    );
  }
}
