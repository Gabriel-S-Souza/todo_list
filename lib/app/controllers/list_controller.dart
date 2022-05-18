import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/local/tasks_dao.dart';
import '../models/task.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {
  final int index;
  ListControllerBase(
    this.index,
  );

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

  @observable
  bool isLoading = false;

  @observable
  bool isTasksObtained = false;

  @action
  Future<void> addTask() async {
    await tasksDAO.create(newTask);
    tasks.add(Task(newTask));
    newTask = '';
    textEditingController.clear();
  }

  @action
  Future<void> removeTask(int i) async {
    await tasksDAO.delete(i);
    tasks.removeAt(i);
  }

  @action
  Future<void> updateTask(int i, String newTask) async {
    await tasksDAO.update(i, newTask);
    tasks.replaceRange(i, i + 1, [Task(newTask)]);
  }

  @action
  Future<void> getTasks() async {
    isLoading = true;
    tasksDAO = TasksDAO(index);
    List<Task> responseTask = [];

    await Future.delayed(const Duration(seconds: 3), () async {
      responseTask = await tasksDAO.read();
    });
    
    responseTask.map((e) {
      tasks.add(e);
    }).toList();
    isLoading = false;
    isTasksObtained = true;
  }
}