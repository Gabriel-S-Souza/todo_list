import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/local/tasks_dao.dart';
import '../models/task.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {
  final int index;
  ListControllerBase(this.index) {
    _initializeTasks();
  }
  
  late final TasksDAO tasksDAO;
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
  Future<void> addTask() async {
    await tasksDAO.create(newTask);
    tasks.add(Task(newTask));
    newTask = '';
    textEditingController.clear();
  }

  @action
  void removeTask(int i) async {
    await tasksDAO.delete(index, i);
    tasks.removeAt(i);
  }

  @action
  Future<void> _initializeTasks() async {
    tasksDAO = TasksDAO(index);
    List<Task> responseTask = await tasksDAO.readAll();
    responseTask.map((e) {
      tasks.add(e);
    }).toList();
  }
}