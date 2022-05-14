import 'package:get_it/get_it.dart';
import 'package:todo_list/app/data_sources/contracts/contract_crud.dart';
import 'package:todo_list/app/data_sources/local/boards_dao.dart';
import 'package:todo_list/app/models/task_board_model.dart';

import '../../models/task.dart';

class TasksDAO extends ContractCRUD {
  final int index;
  TasksDAO(this.index) {
    assignBoard();
  }
  
  TasksBoardModel? _board;

  @override
  void create(String data) {
    // TODO: implement create
  }

  @override
  void delete(int index) {
    // TODO: implement delete
  }

  @override
  void deleteAll() {
    // TODO: implement deleteAll
  }

  @override
  read(int index) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<List<Task>> readAll() async {
    List<Task> taskList = [];
    _board?.tasks.map((e) {
      taskList.add(Task(e));
    }).toList();

    return Future.value(taskList);
  }

  @override
  void update(int index, data) {
    // TODO: implement update
  }

  void assignBoard() async {
    final BoardDAO boardDAO = GetIt.I.get<BoardDAO>();
    TasksBoardModel? boardResponse = await boardDAO.read(index);
    if (boardResponse != null) {
      _board = boardResponse;
    }
  }
}