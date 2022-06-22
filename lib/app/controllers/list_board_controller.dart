import 'dart:developer';

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
  Future<void> addBoard(String title) async {
    final tempBoard = TasksBoardModel()
      ..title = title
      ..id = 'tempBoard'
      ..tasks = {};


    boards.add(tempBoard);
    
    boardsDataManager.create(title, boards.length - 1)
      .then((valueResponse) {
        if(valueResponse is TasksBoardModel) {
          boards.where((element) => element.id == 'tempBoard').first.id = valueResponse.id;
        } else {
          boards.removeWhere((element) => element.id == 'tempBoard');
        }
      });
  }

  Future<void> removeBoard(int index) async {
    final TasksBoardModel boardRemoved = boards[index];
    final List<TasksBoardModel> boardsBackup = List.from(boards);
    

    boards.removeAt(index);

    _adjustPositionBoards();


    boardsDataManager.delete(boardRemoved.id)
      .then((valueResponse) {
        if(valueResponse.runtimeType == TasksBoardModel) {
          boards.where((element) => element.position >= boardRemoved.position).forEach((element) async {
            boardsDataManager.update(element);
          });
        } else {
          boards = ObservableList<TasksBoardModel>.of(boardsBackup);
          return;
        }
      });
  }

  //TODO: adaptar
  @action
  Future<dynamic> moveBoard(int insertIndex, int oldIndex) async {
    TasksBoardModel boardMoved = boards.removeAt(oldIndex);
    boards.insert(insertIndex, boardMoved);
    await boardsDataManager.deleteAll();
    return await boardsDataManager.createFromList(boards);
  }

  @action
  Future<void> _initializeBoards() async {
    isLoading = true;
    List<TasksBoardModel>? boardsList = [];
     boardsList = await boardsDataManager.read() as List<TasksBoardModel>?;
    boards.clear();
    if (boardsList != null) {
      for (var i = 0; i < boardsList.length; i++) {
        TasksBoardModel _board = boardsList.where((element) => element.position == i).first;
        boards.add(_board);
      }
    }
    isLoading = false;
  }

  @action
  Future<dynamic> _getTasks() async {
    List<TasksBoardModel> boardsList = [];
    boardsList = await boardsDataManager.read();
    boards.clear();
    return boardsList.map((e) {
      boards.add(e);
    }).toList();
  }

  @action
  Future<void> addTask(int outerIndex) async{
    final Map<int, String> tasksCopy = Map.from(boards[outerIndex].tasks);
    final Map<int, String> tasksBackup = Map.from(boards[outerIndex].tasks);
    boards[outerIndex].tasks[tasksCopy.length] = newTask;

    boardsDataManager.createTask(newTask, tasksCopy, boards[outerIndex].id)
        .then((value) => _checkRequisitionTaskSuccess(value, tasksBackup, outerIndex));

    newTask = '';
    textEditingController.clear();
  }
  
  @action
  Future<void> removeTask(int innerIndex, int outerIndex) async {    
    final Map<int, String> tasksCopy = Map.from(boards[outerIndex].tasks);
    final Map<int, String> tasksBackup = Map.from(boards[outerIndex].tasks);

    for (var i = 0; i < tasksCopy.length; i++) {
      if (innerIndex == tasksCopy.keys.toList()[i]) {
        tasksCopy.remove(tasksCopy.keys.toList()[i]);
        continue;
      }
    }

    final tasksAdjusted = _adjustKeys(tasksCopy);

    boards[outerIndex].tasks = Map.from(tasksAdjusted);
    
    boardsDataManager.updateTask(tasksAdjusted, boards[outerIndex].id)
        .then((value) => _checkRequisitionTaskSuccess(value, tasksBackup, outerIndex));
  }

  @action
  void moveTask(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    final String taskMoved = boards[oldListIndex].tasks[oldItemIndex]!;
    final Map<int, String> tasksBackupNew = Map.from(boards[oldListIndex].tasks);
    final Map<int, String> tasksBackupOld = Map.from(boards[oldListIndex].tasks);
    final Map<int, String> tasksCopyNew = {};
    final Map<int, String> tasksCopyOld = Map.from(boards[oldListIndex].tasks);

    tasksCopyOld.remove(oldItemIndex);
    final tasksOldAdjusted = _adjustKeys(tasksCopyOld);
    
    boards[newListIndex].tasks.forEach((key, value) { 
      if (key < newItemIndex) {
        tasksCopyNew[key] = value;
      } else {
        tasksCopyNew[key + 1] = value;
      }
    });

    tasksCopyNew[newItemIndex] = taskMoved;

    boards[newListIndex].tasks = Map.from(tasksCopyNew);
    boards[oldListIndex].tasks = Map.from(tasksOldAdjusted);

    boardsDataManager.moveTask(tasksOldAdjusted, boards[oldListIndex].id, tasksCopyNew, boards[newListIndex].id)
        .then((value) => _checkRequisitionTaskSuccess(
            value[0], 
            null, 
            null,
            newListIndex: newListIndex,
            oldListIndex: oldListIndex,
            tasksBackupNew: tasksBackupNew,
            tasksBackupOld: tasksBackupOld
            ));
  }

  Future<void> updateTask(String taskEdited, int innerIndex, int outerIndex) async {
    final Map<int, String> tasksBackup = Map.from(boards[outerIndex].tasks);

    boards[outerIndex].tasks[innerIndex] = taskEdited;

    final Map<int, String> tasksCopy = Map.from(boards[outerIndex].tasks);

    boardsDataManager.updateTask(tasksCopy, boards[outerIndex].id)
        .then((value) => _checkRequisitionTaskSuccess(value, tasksBackup, outerIndex));
  }

  Map<int, String> _adjustKeys(Map<int, String> tasks) {
    final Map<int, String> tasksAdjusted = {};
    for (var i = 0; i < tasks.length; i++) {
      tasksAdjusted[i] = tasks.values.toList()[i];
    }
    return tasksAdjusted;
  }

  void _adjustPositionBoards() {
    for (var i = 0; i < boards.length; i++) {
      boards[i].position = i;
    }
  }

  bool _checkRequisitionTaskSuccess(dynamic response, Map<int, String>? tasksBackup, 
      int? outerIndex, {int? newListIndex, int? oldListIndex, Map<int, String>? tasksBackupNew, 
      Map<int, String>? tasksBackupOld}) {
    response is TasksBoardModel
      ? null
      : newListIndex == null 
          ? boards[outerIndex!].tasks = Map.from(tasksBackup!) 
          : {
              boards[newListIndex].tasks = Map.from(tasksBackupNew!),
              boards[oldListIndex!].tasks = Map.from(tasksBackupOld!),
            };
    
    return response is TasksBoardModel;
  }
}