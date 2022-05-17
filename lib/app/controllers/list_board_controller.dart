import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/contracts/boards_data_manager.dart';
import 'package:todo_list/app/models/task_board_model.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  final IBoardsDataManager boardsDataManager;
  ListBoardControllerBase({required this.boardsDataManager}) {
      _initializeBoards();
  }

  ObservableList<TasksBoardModel> boardsName = ObservableList<TasksBoardModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> addBoard(String value) async {
    await boardsDataManager.create(value);
    boardsName.add(TasksBoardModel()
      ..title = value);
  }

  @action
  Future<void> removeBoard(int index) async {
    await boardsDataManager.delete(index);
    boardsName.removeAt(index);
  }

  @action
  Future<void> _initializeBoards() async {
    isLoading = true;
    List<TasksBoardModel> boardsList = [];
    await Future.delayed(Duration(seconds: 3), () async {
     boardsList = await boardsDataManager.read();
    });
    boardsList.map((e) {
      boardsName.add(e);
    }).toList();
    isLoading = false;
  }
}