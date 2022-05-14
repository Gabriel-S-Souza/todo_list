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
  
  final BoardDAO boardDAO = GetIt.I.get<BoardDAO>();
  TasksBoardModel? _board;

  //TODO: não está funcionando
  @override
  void create(String data) {
    if (_board != null) {
      boardDAO.box.put(index, TasksBoardModel()
    ..title = _board!.title
    ..tasks.add(data));
    }
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
    TasksBoardModel? boardResponse = await boardDAO.read(index);
    if (boardResponse != null) {
      _board = boardResponse;
    }
  }
}