import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginLogic {
  Future<bool> loginUser(String email, String password) async {
    try {
      // Send login request to the server
      final loginUrl = 'https://your-api-url.com/login';
      final response = await http.post(
        Uri.parse(loginUrl),
        body: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        // Login successful
        // Save the authentication token to local storage (e.g., shared preferences)
        return true;
      } else {
        // Login failed
        return false;
      }
    } catch (e) {
      // Error occurred during login
      return false;
    }
  }
}
