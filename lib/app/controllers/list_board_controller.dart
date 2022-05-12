import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/models/tasks_card.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  ListBoardControllerBase() {
    box.values.map((value) {
      addCard(value);
    }).toList();
  }
  
  final Box box = Hive.box<String>('task_boards');

  ObservableList<TasksBoard> cardsName = ObservableList<TasksBoard>();

  @action
  void addCard(String value) {
    cardsName.add(TasksBoard(value));
  }

  @action
  void removeCard(int index) {
    cardsName.removeAt(index);
  }
}