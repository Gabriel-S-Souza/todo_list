import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../controllers/list_board_controller.dart';
import '../data_sources/local/boards_dao.dart';
import '../models/task_board_model.dart';

class ServiceLocator {
  static void initDependencies(Box<TasksBoardModel> box) {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<Box<TasksBoardModel>>(box);
    getIt.registerSingleton<ListBoardController>(ListBoardController(boardsDataManager: BoardDAO()));
  }
}