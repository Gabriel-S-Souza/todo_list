import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/app/models/default_boards.dart';
import 'package:todo_list/app/models/task_board_hive_adapter.dart';

import 'app/controllers/list_board_controller.dart';
import 'app/models/task_board_model.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskBoardAdapter());
  Box<TasksBoardModel> box = await Hive.openBox<TasksBoardModel>('boards_teste');

  if (box.isEmpty) {
    DefaultBoards.defaultBoards.map((e) {
      box.add(TasksBoardModel() ..title = e);
    }).toList();
    
  }
  print(box.values.map((e) => e.title).toList());
  
  // box.deleteAll(box.values.map((e) => e.title).toList());

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<Box<TasksBoardModel>>(box);
  getIt.registerSingleton<ListBoardController>(ListBoardController());
  
  runApp(const MyApp());
}