import 'package:flutter/material.dart';
import 'package:lastfm_app/api/user_requests.dart';
import 'package:lastfm_app/api/user_data.dart';
import 'package:lastfm_app/widgets/bottom_nav.dart';
import 'package:lastfm_app/api/user_search_result.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name = '';
  String _email = '';
  List<String> _friends = [];
  List<Map<String, String>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final userData = await UserAPI.fetchUser();
      final friendsData = await UserAPI.fetchFriendsOfUser();

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

  Future<List<Map<String, String>>> _searchUsers(String query) async {
    try {
      final results = await UserAPI.fetchUsers(query);
      final List<Map<String, String>> userList = results.map((user) {
        final name = user['name']?.toString() ?? '';
        final email = user['email']?.toString() ?? '';
        return {
          'name': name,
          'email': email,
        };
      }).toList();
      return userList;
    } catch (error) {
      _showErrorDialog('Error occurred while searching for users.');
      return [];
    }
  }

  void _navigateToResultPage(List<Map<String, String>> results) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(userList: results),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AboutDialog(
                    applicationName: 'Music APP',
                    applicationVersion: '0.1.4',
                    applicationLegalese: 'Kinga © 2023',
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name:',
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                SizedBox(height: 10.0),
                Text(
                  _name,
                  style: TextStyle(fontSize: 24.0, color: Colors.blue),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Email:',
                  style: TextStyle(fontSize: 20.0, color: Colors.blue),
                ),
                SizedBox(height: 10.0),
                Text(
                  _email,
                  style: TextStyle(fontSize: 24.0, color: Colors.blue),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Friends:',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _friends.length,
                      itemBuilder: (context, index) {
                        return Text(
                          _friends[index],
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for users',
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (value) {
                _searchUsers(value).then((results) {
                  setState(() {
                    _searchResults = results.map((user) => {
                      'name': user['name'] ?? '',
                      'email': user['email'] ?? '',
                    }).toList();
                  });

                  _navigateToResultPage(_searchResults);
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: 0,
        onItemTapped: (index) {
          // No navigation logic here, handled in BottomNav widget
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _performLogout,
        label: Text(
          'Log Out',
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
