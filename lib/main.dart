import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app/data_sources/local/boards_dao.dart';
import 'package:todo_list/app/repositories/hive_app.dart';
import 'app/controllers/list_board_controller.dart';
import 'app/models/task_board_model.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Box<TasksBoardModel> box = await HiveApp.init();

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<Box<TasksBoardModel>>(box);
  getIt.registerSingleton<ListBoardController>(ListBoardController(boardsDataManager: BoardDAO()));
  
  runApp(const MyApp());
}