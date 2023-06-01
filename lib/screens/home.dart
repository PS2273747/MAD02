import 'package:flutter/material.dart';
import 'package:lastfm_app/widgets/bottom_nav.dart';
import 'package:lastfm_app/API/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService authService = AuthService();
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    authService.checkAuthStatus().then((isLoggedIn) {
      setState(() {
        _isLoggedIn = isLoggedIn;
      });
    });
  }

  void _handleLogin(String email, String password) async {
    try {
      await authService.handleLogin(context, email, password);
      setState(() {
        _isLoggedIn = true;
      });
    } catch (e) {
      // Handle login error here
      print('Login failed: $e');
    }
  }

  void _handleRegister(String name, String email, String password) async {
    try {
      await authService.handleRegister(context, name, email, password);
      setState(() {
        _isLoggedIn = true;
      });
    } catch (e) {
      // Handle registration error here
      print('Registration failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Last.fm App'),
      ),
      body: Center(
        child: _isLoggedIn
            ? const Text('Welcome to Last.fm App!')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AboutDialog(
                      applicationName: 'Last.fm App',
                      applicationVersion: '0.0.2',
                      children: const [
                        Text('This is a music app.'),
                        Text('Developed by Kinga Wullems'),
                      ],
                    );
                  },
                );
              },
              child: Column(
                children: [
                  Icon(
                    Icons.music_note,
                    size: 100,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Music App',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _handleLogin('example@example.com', 'password123');
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _handleRegister('John Doe', 'johndoe@example.com', 'password123');
              },
              child: const Text('Register'),
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
