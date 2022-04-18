import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              child: const Icon(Icons.home)),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/settings'),
              child: const Icon(Icons.settings)),
        ]),
      ),
    );
  }
}
