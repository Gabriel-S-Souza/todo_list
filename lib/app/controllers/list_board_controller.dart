import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/local/boards_dao.dart';
import 'package:todo_list/app/models/task_board_model.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  ListBoardControllerBase() {
      _initializeBoards();
  }

  final BoardDAO boardDAO = BoardDAO();

  ObservableList<TasksBoardModel> boardsName = ObservableList<TasksBoardModel>();

  @action
  Future<void> addBoard(String value) async {
    await boardDAO.create(value);
    boardsName.add(TasksBoardModel()
      ..title = value);
  }

  @action
  Future<void> removeBoard(int index) async {
    await boardDAO.delete(index);
    boardsName.removeAt(index);
  }

  @action
  Future<void> _initializeBoards() async {
    List<TasksBoardModel> boardsList = await boardDAO.readAll();

    boardsList.map((e) {
      boardsName.add(e);
    }).toList();
  }
}