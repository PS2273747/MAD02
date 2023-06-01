import 'package:flutter/material.dart';
import 'package:lastfm_app/widgets/bottom_nav.dart';
//test

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Last.fm App'),
      ),
      body: Center(
        child: InkWell(
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
            mainAxisAlignment: MainAxisAlignment.center,
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
                  color: Colors.blue, // Set the text color to blue
                ),
              ),
            ],
          ),
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
