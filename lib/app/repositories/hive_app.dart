import 'package:hive_flutter/hive_flutter.dart';

import '../models/default_boards.dart';
import '../models/task_board_hive_adapter.dart';
import '../models/task_board_model.dart';

class HiveApp {
  static Future<Box<TasksBoardModel>> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskBoardAdapter());
    Box<TasksBoardModel> box = await Hive.openBox<TasksBoardModel>('boards_teste');
    if (box.isEmpty) {
      DefaultBoards.defaultBoards.map((e) async {
        await box.add(TasksBoardModel() 
            ..title = e
            ..tasks = e == DefaultBoards.defaultBoards[0] ? ['Mude o status das tarefas arrastando-as para os outros quadros'] : []);
                
      }).toList();
    }

    return box;
  }
}