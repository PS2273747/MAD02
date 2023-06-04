import 'dart:convert';
import 'package:http/http.dart' as http;
import '../classes/user_data.dart';
import 'package:flutter/material.dart';
import 'package:lastfm_app/screens/user_profile_screen.dart';

class FriendRequest {
  static const String baseUrl = 'http://10.0.2.2:8000/api/';

  static Future<void> makeFriend(String friendEmail) async {
    print('enters MakeFriend Function');
    final url = Uri.parse(baseUrl + 'users/befriend');

    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer ${UserData.authToken}',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'friend_email': friendEmail}),
    );

    print('Friend email: $friendEmail');

    if (response.statusCode == 200) {
      print('Friend added successfully');
    } else {
      print('Failed to add friend: ${response.statusCode}');
    }
  }

  static Future<void> unFriend(String friendEmail) async {
    try {
      final url = Uri.parse(baseUrl + 'users/unfriend');
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${UserData.authToken}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'friend_email': friendEmail}),
      );

      if (response.statusCode == 200) {
        // Friendship deleted successfully
        print('Friendship deleted successfully');
      } else {
        print('Failed to delete friendship: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
    }
  }
}
