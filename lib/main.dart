import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app/data_sources/http/http_client.dart';
import 'package:todo_list/app/data_sources/local/boards_dao.dart';
import 'package:todo_list/app/repositories/hive_app.dart';
import 'app/controllers/list_board_controller.dart';
import 'app/models/task_board_model.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Box<TasksBoardModel> box = await HiveApp.init();

  // final responsePost = await dioClient.post(
  //   body: [{
  //       "title": "A fazer",
  //       "tasks": [
  //           "Estudar Flutter",
  //           "Estudar Dart",
  //           "Estudar consumo de APIS REST"
  //       ]
  //   }]
  // );
  

  GetIt getIt = GetIt.I;
  getIt.registerSingleton<ListBoardController>(ListBoardController(boardsDataManager: HttpTaskBoardManager()));
  
  runApp(const MyApp());
}