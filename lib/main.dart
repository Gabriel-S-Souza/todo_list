import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/app/models/default_boards.dart';

import 'app/controllers/list_board_controller.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Box<String> box = await Hive.openBox<String>('boards');

  if (box.isEmpty) {
    box.addAll(DefalutBoards.defaultBoards);
  }
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<Box<String>>(box);
  getIt.registerSingleton<ListBoardController>(ListBoardController());
  
  runApp(const MyApp());
}