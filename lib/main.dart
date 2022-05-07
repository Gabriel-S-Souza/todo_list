import 'package:flutter/material.dart';
import 'package:todo_list/screens/list_screen.dart';

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
        primaryColor: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.blue),
      ),
      //TODO: adicionar a LoginScreen como primeira tela
      home: const ListScreen(),
    );
  }
}