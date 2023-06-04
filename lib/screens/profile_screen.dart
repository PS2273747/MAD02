import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final bool isFriend;

  ProfilePage({required this.name, required this.email, required this.isFriend});

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
              'Name: $name',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 10.0),

            if (isFriend)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email: $email',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Friends:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 10.0),
                  // TODO: Display friend list and song list
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
                    onPressed: () {
                      // TODO: Logic for adding user as friend
                    },
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
