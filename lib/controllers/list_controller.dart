import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {

  final TextEditingController textEditingController = TextEditingController();

  @observable
  String newTask = '';

  @action
  void setNewTask(String value) => newTask = value;

  @computed
  bool get isNewTaskValid => newTask.isNotEmpty;

  @computed
  VoidCallback? get addTaskTaped => isNewTaskValid ? addTask : null;

  //Lista observável do Mobx, portanto não é necessário adicionar o @observable
  ObservableList<String> tasks = ObservableList<String>();

  @action
  void addTask() {
    tasks.insert(0, newTask);
    textEditingController.clear();
    newTask = '';
  }
}