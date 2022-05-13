import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/local_data_dao.dart';
import 'package:todo_list/app/models/task_board_model.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  ListBoardControllerBase() {
      _initializeBoards();
  }

  final LocalDataDAO localDataDAO = GetIt.I.get<LocalDataDAO>();

  ObservableList<TasksBoardModel> cardsName = ObservableList<TasksBoardModel>();

  @action
  Future<void> addCard(String value) async {
    await localDataDAO.create(value);
    cardsName.add(TasksBoardModel()
      ..title = value);
  }

  @action
  Future<void> removeCard(int index) async {
    await localDataDAO.delete(index);
    cardsName.removeAt(index);
  }

  @action
  void _initializeBoards() {
    List<TasksBoardModel> boardsList = localDataDAO.read();

    boardsList.map((e) {
      cardsName.add(e);
    }).toList();
  }
}