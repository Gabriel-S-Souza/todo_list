import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app/data_sources/contracts/tasks_data_manager.dart';
import 'package:todo_list/app/models/task_board_model.dart';

class TasksDAO implements ITasksDataManager {

  final Box<TasksBoardModel> box = GetIt.I.get<Box<TasksBoardModel>>();
  
  @override
  Future<void> create(String data, int outerIndex, [int? insertIndex]) async {
    TasksBoardModel? board = box.getAt(outerIndex);
    if (board != null) {
      String title = board.title;
      List<String> tasks = board.tasks;

      if (insertIndex != null) {
        tasks.insert(insertIndex, data);
        
      } else {
        tasks.add(data);
      }
      
      return box.putAt(outerIndex, TasksBoardModel()
        ..title = title
        ..tasks = tasks);
    }
  }

  
  
  @override
  Future<void> delete(int innerIndex, outerIndex) async {
    TasksBoardModel? board = box.getAt(outerIndex);
    if (board != null) {
      String title = board.title;
      List<String> tasks = board.tasks;
      tasks.removeAt(innerIndex);
      return box.putAt(outerIndex, TasksBoardModel()
        ..title = title
        ..tasks = tasks);
    }
  }
  
  @override
  Future<List<List<String>>> read() {
    List<TasksBoardModel> board = box.values.toList();
    
    Future.value();

    List<List<String>> taskListList = [];

    if (board != null) {
      board.map((e) {
        List<String> taskList = [];

        e.tasks.map((e) {
          taskList.add(e);
        }).toList();

        taskListList.add(taskList);

      }).toList();
    }

    return Future.value(taskListList);
  }

  @override
  Future<void> update(String newTask, int innerIndex, int outerIndex) async {
    TasksBoardModel? board = box.getAt(outerIndex);
    if (board != null) {
      String title = board.title;
      List<String> tasks = board.tasks;
      tasks.replaceRange(innerIndex, innerIndex + 1, [newTask]);
      return box.putAt(outerIndex, TasksBoardModel()
        ..title = title
        ..tasks = tasks);
    }
  }
}