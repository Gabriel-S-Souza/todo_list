import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list/app/data_sources/local/boards_dao.dart';
import 'app/controllers/list_board_controller.dart';
import 'app/view/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  BoardDAO boardDAO = BoardDAO();
  await boardDAO.openDataBase();

  GetIt getIt = GetIt.I;

  getIt.registerSingleton<BoardDAO>(boardDAO);
  getIt.registerSingleton<ListBoardController>(ListBoardController());
  
  runApp(const MyApp());
}