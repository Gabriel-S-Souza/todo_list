import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/local/boards_dao.dart';
import 'package:todo_list/app/models/task_board_model.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  ListBoardControllerBase() {
      _initializeBoards();
  }

  final LocalDataDAO localDataDAO = GetIt.I.get<LocalDataDAO>();

  ObservableList<TasksBoardModel> boardsName = ObservableList<TasksBoardModel>();

  @action
  Future<void> addBoard(String value) async {
    await localDataDAO.create(value);
    boardsName.add(TasksBoardModel()
      ..title = value);
  }

  @action
  Future<void> removeBoard(int index) async {
    await localDataDAO.delete(index);
    boardsName.removeAt(index);
  }

  @action
  Future<void> _initializeBoards() async {
    List<TasksBoardModel> boardsList = await localDataDAO.readAll();

    boardsList.map((e) {
      boardsName.add(e);
    }).toList();
  }
}