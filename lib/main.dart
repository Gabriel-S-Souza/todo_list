import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app/data_sources/local/boards_dao.dart';
import 'app/controllers/list_board_controller.dart';
import 'app/models/default_boards.dart';
import 'app/models/task_board_hive_adapter.dart';
import 'app/models/task_board_model.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Hive.initFlutter();
  Hive.registerAdapter(TaskBoardAdapter());
  Box<TasksBoardModel> box = await Hive.openBox<TasksBoardModel>('boards_teste');
  if (box.isEmpty) {
    DefaultBoards.defaultBoards.map((e) {
      box.add(TasksBoardModel() 
          ..title = e
          ..tasks = e == DefaultBoards.defaultBoards[0] ? ['Mude o status das tarefas arrastando-as para os outros quadros'] : []);
              
    }).toList();
  }

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<Box<TasksBoardModel>>(box);
  getIt.registerSingleton<ListBoardController>(ListBoardController(boardsDataManager: BoardDAO()));
  
  runApp(const MyApp());
}