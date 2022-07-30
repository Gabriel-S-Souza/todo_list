import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../controllers/list_board_controller.dart';
import '../data_sources/local/boards_dao.dart';
import '../models/task_board_model.dart';

class ServiceLocator {
  static Future<void> initDependencies(Box<TasksBoardModel> box) async {
    GetIt getIt = GetIt.I;
    getIt.registerSingleton<Box<TasksBoardModel>>(box);
    Box boxUser = await Hive.openBox<dynamic>('user_login');
    getIt.registerSingleton<Box>(boxUser);
    getIt.registerSingleton<ListBoardController>(ListBoardController(boardsDataManager: BoardDAO()));
  }

  static GetIt get getIt => GetIt.I;
}