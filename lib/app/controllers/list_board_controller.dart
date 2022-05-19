import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list/app/data_sources/contracts/boards_data_manager.dart';
import 'package:todo_list/app/models/task_board_model.dart';

part 'list_board_controller.g.dart';

class ListBoardController = ListBoardControllerBase with _$ListBoardController;

abstract class ListBoardControllerBase with Store {
  final IBoardsDataManager boardsDataManager;
  ListBoardControllerBase({required this.boardsDataManager}) {
      _initializeBoards();
  }

  ObservableList<TasksBoardModel> boards = ObservableList<TasksBoardModel>();
  
  final TextEditingController textEditingController = TextEditingController();
  
  @observable
  String newTask = '';

  @observable
  int? selectedImputBoard;

  void setSelectedImputBoard(int? index) => selectedImputBoard = index;

  @action
  void setNewTask(String value) {
    newTask = value;
  }

  @computed
  bool get isNewTaskValid => newTask.isNotEmpty;

  @observable
  bool isLoading = false;

  @action
  Future<void> addBoard(String value) async {
    await boardsDataManager.create(value);
    boards.add(TasksBoardModel()
      ..title = value);
  }

  @action
  Future<dynamic> moveBoard(int insertIndex, int oldIndex) async {
    TasksBoardModel boardMoved = boards.removeAt(oldIndex);
    boards.insert(insertIndex, boardMoved);
    await boardsDataManager.deleteAll();
    return await boardsDataManager.createFromList(boards);
  }

  @action
  Future<void> removeBoard(int index) async {
    await boardsDataManager.delete(index);
    boards.removeAt(index);
  }

  @action
  Future<void> _initializeBoards() async {
    isLoading = true;
    List<TasksBoardModel> boardsList = [];
    // await Future.delayed(const Duration(seconds: 3), () async {
     boardsList = await boardsDataManager.read();
    // });
    boards.clear();
    boardsList.map((e) {
      boards.add(e);
    }).toList();
    isLoading = false;
  }

  @action
  _getTasks() async {
    List<TasksBoardModel> boardsList = [];
     boardsList = await boardsDataManager.read();
    boards.clear();
    boardsList.map((e) {
      boards.add(e);
    }).toList();
  }

  @action
  Future<void> addTask(int outerIndex, [int? insertIndex]) async {
    if (insertIndex != null) {
      await boardsDataManager.createTask(newTask, outerIndex, insertIndex);
      // boards[outerIndex].tasks.insert(insertIndex, newTask);
    } else {
      await boardsDataManager.createTask(newTask, outerIndex);
      // boards[outerIndex].tasks.add(newTask);
    }
    newTask = '';
    textEditingController.clear();
  }

  @action
  Future<void> removeTask(int innerIndex, int outerIndex) async {
    await boardsDataManager.deleteTask(innerIndex, outerIndex);
    // boards[outerIndex].tasks.removeAt(innerIndex);
  }

  @action
  void moveTask(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    print('controller: oldItemIndex: $oldItemIndex, oldListIndex: $oldListIndex, newItemIndex: $newItemIndex, newListIndex: $newListIndex');
    boardsDataManager.moveTask(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
    boards = ObservableList<TasksBoardModel>.of(boards);
  }

  Future<void> updateTask(String taskEdited, int innerIndex, int outerIndex) async {
    await boardsDataManager.updateTask(taskEdited, innerIndex, outerIndex);
  }
}



  // String newTask = '';

  // int? selectedImputBoard;

  // void setSelectedImputBoard(int? index) => selectedImputBoard = index;

  // void setNewTask(String value) {
  //   newTask = value;
  // }

  // bool get isNewTaskValid => newTask.isNotEmpty;

  // ObservableMap<int, List<String>> tasksMap = ObservableMap<int, List<String>>();

  // bool isLoadingTasks = false;

  // bool isTasksObtained = false;

  // Future<void> addTask(int outerIndex, [int? insertIndex]) async {
  //   if (tasksMap.containsKey(outerIndex)) {

  //     if (insertIndex != null) {
  //       await tasksDataManager.create(newTask, outerIndex, insertIndex);

  //       tasksMap[outerIndex]?.insert(insertIndex, newTask);

  //     } else {
  //       await tasksDataManager.create(newTask, outerIndex);

  //       tasksMap[outerIndex]?.add(newTask);
  //     }

  //     newTask = '';
  //     textEditingController.clear();

  //   } else {
  //     throw Exception('Outer index not found');
  //   }
  // }

  // Future<void> removeTask(int innerIndex, int outerIndex) async {
  //   if (tasksMap.containsKey(outerIndex) && tasksMap[outerIndex]!.length > innerIndex) {
  //     await tasksDataManager.delete(innerIndex, outerIndex);
  //     Map<int, List<String>> newTasksMap = tasksMap;

  //     newTasksMap[outerIndex]?.removeAt(innerIndex);

  //     tasksMap =  ObservableMap<int, List<String>>.of(newTasksMap);
  //   } else {
  //     throw Exception('Task not found');
  //   }
  // }

  // Future<void> updateTask(String newTask, int innerIndex, int outerIndex) async {
    
  //   if (tasksMap.containsKey(outerIndex) && tasksMap[outerIndex]!.length > innerIndex) {

  //     await tasksDataManager.update(newTask, innerIndex, outerIndex);
  //     Map<int, List<String>> newTasksMap = tasksMap;

  //     newTasksMap[outerIndex]?.replaceRange(innerIndex, innerIndex + 1, [newTask]);
  //     tasksMap =  ObservableMap<int, List<String>>.of(newTasksMap);
      
  //   } else {
  //     throw Exception('Task not found');
  //   }
  // }
 
  // void toggleIsTasksObtained() => isTasksObtained = !isTasksObtained;

  // void addNewKey() {
  //   int outerIndex = tasksMap.keys.length;
  //   tasksMap.putIfAbsent(outerIndex, () => []);
  // }

  // void moveBoard(int insertIndex, int oldIndex) {
  //   List<List<String>> newTasksList = tasksMap.values.toList();
  //   List<String> boardMoved = newTasksList[oldIndex];
  //   newTasksList.removeAt(oldIndex);
  //   newTasksList.insert(insertIndex, boardMoved);
  //   tasksMap.clear();
  //   tasksMap = ObservableMap<int, List<String>>.of(newTasksList.asMap());
  // }

  // void removeKey(int outerIndex) {
  //   List<List<String>> newTasksList = tasksMap.values.toList();
  //   newTasksList.removeAt(outerIndex);
  //   tasksMap = ObservableMap<int, List<String>>.of(newTasksList.asMap());
  // }

  // Future<void> getTasks() async {
  //   isLoading = true;
  //   isTasksObtained = false;
  //   List<List<String>> responseTask = [];

  //   await Future.delayed(const Duration(seconds: 3), () async {
  //     responseTask = await tasksDataManager.read();
  //   });

  //   tasksMap = ObservableMap<int, List<String>>.of(responseTask.asMap());

  //   isLoading = false;
  //   isTasksObtained = true;
  // }