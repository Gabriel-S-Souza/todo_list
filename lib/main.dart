import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_list/app/data_sources/local_data_dao.dart';
import 'app/controllers/list_board_controller.dart';
import 'app/models/task_board_model.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalDataDAO localDataDAO = LocalDataDAO();
  
  Box<TasksBoardModel> box = await localDataDAO.openDataBase();

  GetIt getIt = GetIt.I;

  //TODO: retirar a injeção de box
  getIt.registerSingleton<Box<TasksBoardModel>>(box);
  getIt.registerSingleton<LocalDataDAO>(localDataDAO);
  getIt.registerSingleton<ListBoardController>(ListBoardController());
  
  runApp(const MyApp());
}