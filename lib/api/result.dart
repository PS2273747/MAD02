import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final List<String> userList;

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
          return ListTile(
            title: Text(userList[index]),
            // You can add more information here, such as email or profile picture
          );
        },
      ),
    );
  }
}