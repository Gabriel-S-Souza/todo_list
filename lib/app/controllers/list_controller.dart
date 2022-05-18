import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/contracts/tasks_data_manager.dart';

part 'list_controller.g.dart';

class ListController = ListControllerBase with _$ListController;

abstract class ListControllerBase with Store {
  final ITasksDataManager tasksDataManager;
  ListControllerBase({required this.tasksDataManager});
  
  final TextEditingController textEditingController = TextEditingController();

  @observable
  String newTask = '';

  @observable
  int? selectedImputBoard;

  @action
  void setSelectedImputBoard(int? index) => selectedImputBoard = index;

  @action
  void setNewTask(String value) {
    newTask = value;
  }

  @computed
  bool get isNewTaskValid => newTask.isNotEmpty;

  ObservableMap<int, List<String>> tasksMap = ObservableMap<int, List<String>>();

  @observable
  bool isLoading = false;

  @observable
  bool isTasksObtained = false;

  @action
  Future<void> addTask(int outerIndex) async {
    if (tasksMap.containsKey(outerIndex)) {

      await tasksDataManager.create(newTask, outerIndex);

      tasksMap[outerIndex]!.add(newTask);

      newTask = '';
      textEditingController.clear();

    } else {
      throw Exception('Outer index not found');
    }
  }

  @action
  Future<void> removeTask(int innerIndex, int outerIndex) async {
    if (tasksMap.containsKey(outerIndex) && tasksMap[outerIndex]!.length > innerIndex) {
      await tasksDataManager.delete(innerIndex, outerIndex);
      Map<int, List<String>> newTasksMap = tasksMap;

      newTasksMap[outerIndex]?.removeAt(innerIndex);

      tasksMap =  ObservableMap<int, List<String>>.of(newTasksMap);
    } else {
      throw Exception('Task not found');
    }
  }

  @action
  Future<void> updateTask(String newTask, int innerIndex, int outerIndex) async {
    
    if (tasksMap.containsKey(outerIndex) && tasksMap[outerIndex]!.length > innerIndex) {

      await tasksDataManager.update(newTask, innerIndex, outerIndex);
      Map<int, List<String>> newTasksMap = tasksMap;

      newTasksMap[outerIndex]?.replaceRange(innerIndex, innerIndex + 1, [newTask]);
      tasksMap =  ObservableMap<int, List<String>>.of(newTasksMap);
      
    } else {
      throw Exception('Task not found');
    }
  }

  @action 
  void toggleIsTasksObtained() => isTasksObtained = !isTasksObtained;

  @action
  void addNewKey() {
    int outerIndex = tasksMap.keys.length;
    tasksMap.putIfAbsent(outerIndex, () => []);
  }

  @action
  void removeKey(int outerIndex) {
    List<List<String>> newTasksList = tasksMap.values.toList();
    newTasksList.removeAt(outerIndex);
    tasksMap = ObservableMap<int, List<String>>.of(newTasksList.asMap());
  }

  @action
  Future<void> getTasks() async {
    isLoading = true;
    isTasksObtained = false;
    List<List<String>> responseTask = [];

    await Future.delayed(const Duration(seconds: 3), () async {
      responseTask = await tasksDataManager.read();
    });

    tasksMap = ObservableMap<int, List<String>>.of(responseTask.asMap());

    isLoading = false;
    isTasksObtained = true;
  }
}