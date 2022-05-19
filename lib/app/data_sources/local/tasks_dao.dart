import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/app/models/task_board_model.dart';

class TasksDAO {

  final Box<TasksBoardModel> box = GetIt.I.get<Box<TasksBoardModel>>();
  
  Future<void> createTask(String data, int outerIndex, [int? insertIndex]) async {
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

  
  Future<void> deleteTask(int innerIndex, outerIndex) async {
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

  Future<void> updateTask(String newTask, int innerIndex, int outerIndex) async {
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
  

  Future<void> moveTask(int oldOuterIndex, int oldInnerIndex, int newOuterIndex, int newInnerIndex) async {
    TasksBoardModel? board = box.getAt(oldOuterIndex);
    if (board != null) {
      String title = board.title;
      List<String> tasks = board.tasks;
      String taskMoved = tasks[oldInnerIndex];
      tasks.removeAt(oldInnerIndex);
      tasks.insert(newInnerIndex, taskMoved);
      return box.putAt(oldOuterIndex, TasksBoardModel()
        ..title = title
        ..tasks = tasks);
    }
  }

  // Future<List<List<String>>> read() {
  //   List<TasksBoardModel> board = box.values.toList();
    
  //   Future.value();

  //   List<List<String>> taskListList = [];

  //   if (board != null) {
  //     board.map((e) {
  //       List<String> taskList = [];

  //       e.tasks.map((e) {
  //         taskList.add(e);
  //       }).toList();

  //       taskListList.add(taskList);

  //     }).toList();
  //   }

  //   return Future.value(taskListList);
  // }
}