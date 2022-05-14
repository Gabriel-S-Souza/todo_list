import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../data_sources/local/boards_dao.dart';
import '../models/task.dart';
import '../models/task_board_model.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {
  final int index;
  ListControllerBase(this.index) {
    _initializeTasks();
  }
  
  final LocalDataDAO localDataDAO = GetIt.I.get<LocalDataDAO>();
  final TextEditingController textEditingController = TextEditingController();

  @observable
  String newTask = '';

  @action
  void setNewTask(String value) => newTask = value;

  @computed
  bool get isNewTaskValid => newTask.isNotEmpty;

  @computed
  VoidCallback? get addTaskTaped => isNewTaskValid ? addTask : null;

  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  void addTask() {
    tasks.insert(0, Task(newTask));
    newTask = '';
    textEditingController.clear();
  }

  @action
  Future<void> _initializeTasks() async {
    // TasksBoardModel boardsList = await localDataDAO.read(index);

    // boardsList.tasks.map((e) {
    //   tasks.add(Task(e));
    // }).toList();
  }
}