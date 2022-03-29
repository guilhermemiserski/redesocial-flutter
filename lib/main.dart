import 'package:flutter/material.dart';
import 'package:trespaginas/myapp.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyBgqf8HXe458xQcFa3d7M4BhGKADJrOSFA',
    appId: '1:560570583880:android:567e0f9a5bbf29389b417d',
    messagingSenderId: '560570583880',
    projectId: 'login-flutter-4038f',
  ));
  runApp(const MyApp());
}
