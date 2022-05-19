import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/contracts/boards_data_manager.dart';
import 'package:todo_list/app/models/task_board_model.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  final IBoardsDataManager boardsDataManager;
  ListBoardControllerBase({required this.boardsDataManager}) {
      _initializeBoards();
      // autorun((_) {
      //   print('ListBoardControllerBase:');
      //   for (var i = 0; i < boardsName.length; i++) {
      //     print(boardsName[i].title);
      //     print(boardsName[i].tasks);
      //   }
      // });
  }

  ObservableList<TasksBoardModel> boardsName = ObservableList<TasksBoardModel>();

  @observable
  bool isLoading = false;

  @action
  Future<void> addBoard(String value) async {
    isLoading = true;
    await boardsDataManager.create(value);
    boardsName.add(TasksBoardModel()
      ..title = value);
    isLoading = false;
  }

  @action
  Future<void> moveBoard(int insertIndex, int oldIndex) async {
    await boardsDataManager.move(insertIndex, oldIndex);
    List<TasksBoardModel> newBoardsName = await boardsDataManager.read() as List<TasksBoardModel>;
    boardsName.clear();

    // newBoardsName.map((e) {
    //   boardsName.add(e);
    // }).toList();

    boardsName = ObservableList<TasksBoardModel>.of(newBoardsName);
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
    await Future.delayed(const Duration(seconds: 3), () async {
     boardsList = await boardsDataManager.read();
    });
    boardsList.map((e) {
      boardsName.add(e);
    }).toList();
    isLoading = false;
  }
}