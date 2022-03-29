import 'package:flutter/material.dart';
import 'package:trespaginas/src/pages/home_page.dart';
import 'package:trespaginas/src/pages/login_page.dart';
import 'package:trespaginas/src/pages/profile_page.dart';
import 'package:trespaginas/src/pages/settings_page.dart';
import 'package:trespaginas/src/pages/signup_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => MyHomePage(),
        '/profile': (context) => MyProfilePage(),
        '/settings': (context) => MySettingsPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'TresPaginas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
