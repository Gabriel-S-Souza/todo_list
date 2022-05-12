import 'package:mobx/mobx.dart';
import 'package:todo_list/app/models/tasks_card.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {

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