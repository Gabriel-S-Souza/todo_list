import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app/data_sources/contracts/contract_crud.dart';
import 'package:todo_list/app/models/task_board_model.dart';

import '../../models/task.dart';

class TasksDAO implements ContractCRUD {

  final Box<TasksBoardModel> box = GetIt.I.get<Box<TasksBoardModel>>();

  final int index;
  TasksDAO(this.index) {
    // assignBoard();
  }

  
  @override
  Future<void> create(String data) async {
    TasksBoardModel? board = box.getAt(index);
    if (board != null) {
      String title = board.title;
      List<String> tasks = board.tasks;
      tasks.add(data);
      return box.putAt(index, TasksBoardModel()
        ..title = title
        ..tasks = tasks);
    }
  }

  
  
  @override
  Future<void> delete(int i) async {
    TasksBoardModel? board = box.getAt(index);
    if (board != null) {
      String title = board.title;
      List<String> tasks = board.tasks;
      tasks.removeAt(i);
      return box.putAt(index, TasksBoardModel()
        ..title = title
        ..tasks = tasks);
    }
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
  Future<List<Task>> readAll() {
    TasksBoardModel? board = box.getAt(index);
    List<Task> taskList = [];

    if (board != null) {
      board.tasks.map((e) {
        taskList.add(Task(e));
      }).toList();
    }

    return Future.value(taskList);
  }

  //TODO: testar
  @override
  Future<void> update(int i , String task) async {
    TasksBoardModel? board = box.getAt(index);
    if (board != null) {
      String title = board.title;
      List<String> tasks = board.tasks;
      tasks.replaceRange(i, i + 1, [task]);
      return box.putAt(index, TasksBoardModel()
        ..title = title
        ..tasks = tasks);
    }
  }
}