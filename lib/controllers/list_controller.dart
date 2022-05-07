import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {

  @observable
  String newTask = '';

  @action
  void setNewTask(String value) => newTask = value;

  @computed
  bool get isNewTaskValid => newTask.isNotEmpty;

  @computed
  VoidCallback? get addTaskTaped => isNewTaskValid ? addTask : null;

  @action
  void addTask() {
    print('$newTask');
  }
}