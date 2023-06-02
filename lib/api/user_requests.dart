import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_data.dart';
import 'package:flutter/material.dart';
import 'package:lastfm_app/screens/profile_screen.dart';
import 'package:lastfm_app/screens/login_screen.dart';

class UserAPI {
  static const String baseUrl = 'http://10.0.2.2:8000/api/';

  //------GET USER---------
  static Future<Map<String, dynamic>> fetchUser() async {
    final url = Uri.parse(baseUrl + 'user?email=${UserData.userEmail}');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${UserData.authToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to fetch user information');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    }
  }



// ---------LOGIN----------
  static Future<void> login(BuildContext context, String email, String password) async {
    try {
      final url = baseUrl + 'login';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${UserData.authToken}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        UserData.authToken = data['token'];
        UserData.userEmail = email;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
      } else if (response.statusCode == 401) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid credentials.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      print('An error occurred: $e'); // Add this print statement
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('connection error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

//---- REGISTER---
  static Future<void> register(BuildContext context, String name, String email, String password) async {
    try {
      final url = baseUrl + 'register';

      final response = await http.post(
        Uri.parse(url),
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      print('Response Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        // Registration successful, you can handle the success flow here
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Successful'),
            content: Text('You have been registered successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Registration failed, handle the error case
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Failed'),
            content: Text('An error occurred during registration.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Error occurred during the registration process
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  //----- LOGOUT----
  static Future<void> logout(String token) async {


    try {
      final url = baseUrl + 'logout';
      // Make the API request to log out
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Successful logout
        print('Logout successful');
      } else {
        // Error during logout
        print('Logout error');
      }
    } catch (e) {
      // Exception occurred
      print('Error occurred: $e');
    }
  }

}

