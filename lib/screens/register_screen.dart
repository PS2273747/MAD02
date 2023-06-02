import 'package:flutter/material.dart';
import 'package:lastfm_app/screens/login_screen.dart';
import 'package:lastfm_app/api/user_requests.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Register an account to use this app',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    String name = nameController.text;
                    String email = emailController.text;
                    String password = passwordController.text;

                    // Call the register method from RegisterLogic class
                    UserAPI.register(context, name, email, password);
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
