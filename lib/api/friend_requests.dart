import 'dart:convert';
import 'package:http/http.dart' as http;

import 'user_data.dart';

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

}
