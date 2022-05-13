import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/models/task_board_model.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  ListBoardControllerBase() {
    box.values.map((e) {
      TasksBoardModel board = e;
      final String title = board.title;
      _initializeBoards(title);
    }).toList();
  }
  
  final Box box = GetIt.I.get<Box<TasksBoardModel>>();

  ObservableList<TasksBoardModel> cardsName = ObservableList<TasksBoardModel>();

  @action
  void addCard(String value) {
    box.add(TasksBoardModel()
        ..title = value
      );
    cardsName.add(TasksBoardModel()
      ..title = value);
  }

  @action
  void _initializeBoards(String value) {
    cardsName.add(TasksBoardModel()
      ..title = value);
  }

  @action
  void removeCard(int index) {
    cardsName.removeAt(index);
  }
}