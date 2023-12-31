import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_firebase/firebase_options.dart';
import 'package:todo_firebase/pages/auth/auth_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.yellow, useMaterial3: true),
      title: 'Notes Cloud',
      home: const AuthPage(),
    );
  }
}
