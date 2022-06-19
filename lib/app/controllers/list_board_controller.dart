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

  //TODO: adaptar
  @action
  Future<void> addBoard(String value) async {
    await boardsDataManager.create(value);
    boards.add(TasksBoardModel()
      ..title = value);
    
    _getTasks();
  }

  //TODO: adaptar
  @action
  Future<dynamic> moveBoard(int insertIndex, int oldIndex) async {
    TasksBoardModel boardMoved = boards.removeAt(oldIndex);
    boards.insert(insertIndex, boardMoved);
    await boardsDataManager.deleteAll();
    return await boardsDataManager.createFromList(boards);
  }

  //TODO: adaptar
  @action
  Future<void> removeBoard(int index) async {
    await boardsDataManager.delete(index);
    boards.removeAt(index);
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
    // _addPlaceholderTask(outerIndex);

    await boardsDataManager.createTask(newTask, boards[outerIndex].tasks, boards[outerIndex].id);

    newTask = '';
    textEditingController.clear();
  }

  // _addPlaceholderTask(int outerIndex) {
  //   TasksBoardModel _board = boards[outerIndex];
  //   _board.tasks[boards[outerIndex].tasks.length] = newTask;
    
  //   boards[outerIndex] = _board;
  // }

  //TODO: adaptar
  @action
  Future<void> removeTask(int innerIndex, int outerIndex) async {
    await boardsDataManager.deleteTask(innerIndex, outerIndex);
    // boards[outerIndex].tasks.removeAt(innerIndex);
  }

  //TODO: adaptar
  @action
  void moveTask(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    boardsDataManager.moveTask(oldItemIndex, oldListIndex, newItemIndex, newListIndex);
    boards = ObservableList<TasksBoardModel>.of(boards);
  }

  //TODO: adaptar
  Future<void> updateTask(String taskEdited, int innerIndex, int outerIndex) async {
    await boardsDataManager.updateTask(taskEdited, innerIndex, outerIndex);
  }
}