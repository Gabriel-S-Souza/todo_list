import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app/controllers/list_board_controller.dart';
import 'app/models/default_boards.dart';
import 'app/models/task_board_hive_adapter.dart';
import 'app/models/task_board_model.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO: alocar a inicialização do Hive
  
  await Hive.initFlutter();
  Hive.registerAdapter(TaskBoardAdapter());
  Box<TasksBoardModel> box = await Hive.openBox<TasksBoardModel>('boards_teste');
  if (box.isEmpty) {
    DefaultBoards.defaultBoards.map((e) {
      box.add(TasksBoardModel() ..title = e);
    }).toList();
  } else {
    // int index = 1;
    // print(box.getAt(index)?.title);
    // print(box.getAt(index)?.tasks);

    box.keys.toList().map((e) {
      print(box.get(e)?.title);
      print(box.get(e)?.tasks);
    }).toList();
  }

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<Box<TasksBoardModel>>(box);
  getIt.registerSingleton<ListBoardController>(ListBoardController());

  
  
  runApp(const MyApp());
}