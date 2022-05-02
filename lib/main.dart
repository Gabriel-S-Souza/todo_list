import 'package:flutter/material.dart';

import 'screens/login_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MobX Tutorial',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.cyan,
        scaffoldBackgroundColor: Colors.cyan,
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.cyan),
      ),
      home: const LoginScreen(),
    );
  }
}