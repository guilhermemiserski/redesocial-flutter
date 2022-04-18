import 'package:flutter/material.dart';

class MySettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      drawer: Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/home'),
              child: const Icon(Icons.home)),
          TextButton(
              onPressed: () => Navigator.pushNamed(context, '/profile'),
              child: const Icon(Icons.person)),
        ]),
      ),
    );
  }
}
