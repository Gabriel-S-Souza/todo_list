import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/data_sources/local_data_dao.dart';
import 'app/controllers/list_board_controller.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  LocalDataDAO localDataDAO = LocalDataDAO();
  await localDataDAO.openDataBase();

  GetIt getIt = GetIt.I;

  getIt.registerSingleton<LocalDataDAO>(localDataDAO);
  getIt.registerSingleton<ListBoardController>(ListBoardController());
  
  runApp(const MyApp());
}