import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/contracts/tasks_data_manager.dart';
import '../models/task.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {
  
  final ITasksDataManager tasksDataManager;
  ListControllerBase({required this.tasksDataManager});

  final TextEditingController textEditingController = TextEditingController();

  @observable
  String newTask = '';

  @action
  void setNewTask(String value) => newTask = value;

  @computed
  bool get isNewTaskValid => newTask.isNotEmpty;

  ObservableMap<int, List<Task>> tasks = ObservableMap<int, List<Task>>();

  @observable
  bool isLoading = false;

  @action
  Future<void> addTask(int outerIndex) async {
    await tasksDataManager.create(newTask, outerIndex);
    List<Task> tasksCopy = tasks[outerIndex] ?? [];
    tasksCopy.add(Task(newTask));
    tasks[outerIndex] = tasksCopy;
    newTask = '';
    textEditingController.clear();
  }

  @action
  Future<void> removeTask(int innerIndex, int outerIndex) async {
    await tasksDataManager.delete(innerIndex, outerIndex);
    List<Task> tasksCopy = tasks[outerIndex] ?? [];
    tasksCopy.removeAt(innerIndex);
    tasks[outerIndex] = tasksCopy;
  }

  @action
  Future<void> updateTask(int innerIndex, int outerIndex, String newTask) async {
    await tasksDataManager.update(innerIndex, outerIndex, newTask);
    List<Task> tasksCopy = tasks[outerIndex] ?? [];
    tasksCopy.replaceRange(innerIndex, innerIndex + 1, [Task(newTask)]);
    tasks[outerIndex] = tasksCopy;
  }

  @action
  Future<void> read(int outerIndex) async {
    isLoading = true;
    List<Task> responseTask = [];
    
    await Future.delayed(const Duration(seconds: 3), () async {
      responseTask = await tasksDataManager.read(outerIndex);
    });

    tasks[outerIndex] = responseTask;
    
    isLoading = false;
  }
}