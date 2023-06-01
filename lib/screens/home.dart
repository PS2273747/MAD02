import 'package:flutter/material.dart';
import 'package:lastfm_app/API/login_logic.dart';
import 'package:lastfm_app/widgets/bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LoginLogic loginLogic = LoginLogic();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    final bool loginResult = await loginLogic.loginUser(email, password);

    if (loginResult) {
      // Login successful
      // Navigate to the homepage route
      Navigator.pushNamed(context, '/homepage');
    } else {
      // Login failed
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid email or password.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                loginUser(context);
              },
              child: Text('Login'),
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
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Song App',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 16),
            Icon(
              Icons.music_note,
              size: 120,
              color: Colors.blue,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                showLoginDialog(context);
              },
              child: Text(
                'Login',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50),
              ),
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
