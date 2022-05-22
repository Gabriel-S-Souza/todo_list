import 'package:flutter/material.dart';
import 'package:todo_list/app/view/screens/todolist_screen.dart';

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
      home: const TodoListScreen(),
    );
  }
}