// import 'package:get_it/get_it.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:todo_list/app/models/task_board_model.dart';

// class TasksDAO {

//   final Box<TasksBoardModel> box = GetIt.I.get<Box<TasksBoardModel>>();
  
//   Future<void> createTask(String data, int outerIndex, [int? insertIndex]) async {
//     TasksBoardModel? board = box.getAt(outerIndex);
//     if (board != null) {
//       String title = board.title;
//       Map<String, int> tasks = board.tasks;

//       if (insertIndex != null) {
//         tasks.insert(insertIndex, data);
        
//       } else {
//         tasks.add(data);
//       }
      
//       return box.putAt(outerIndex, TasksBoardModel()
//         ..title = title
//         ..tasks = tasks);
//     }
//   }

  
//   Future<void> deleteTask(int innerIndex, outerIndex) async {
//     TasksBoardModel? board = box.getAt(outerIndex);
//     if (board != null) {
//       String title = board.title;
//       List<String> tasks = board.tasks;
//       tasks.removeAt(innerIndex);
//       return box.putAt(outerIndex, TasksBoardModel()
//         ..title = title
//         ..tasks = tasks);
//     }
//   }

//   Future<void> updateTask(String newTask, int innerIndex, int outerIndex) async {
//     TasksBoardModel? board = box.getAt(outerIndex);
//     if (board != null) {
//       String title = board.title;
//       List<String> tasks = board.tasks;
//       tasks.replaceRange(innerIndex, innerIndex + 1, [newTask]);
//       return box.putAt(outerIndex, TasksBoardModel()
//         ..title = title
//         ..tasks = tasks);
//     }
//   }
  

//   Future<void> moveTask(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) async {

//     TasksBoardModel? odlBoard = box.getAt(oldListIndex);
//     TasksBoardModel? newBoard = box.getAt(newListIndex);
    
//     if (odlBoard != null && newBoard != null) {
//       String oldTitle = odlBoard.title;
//       String newTitle = newBoard.title;
//       List<String> oldBoardTasks = odlBoard.tasks;
//       List<String> newBoardTasks = newBoard.tasks;
//       String taskMoved = oldBoardTasks[oldItemIndex];
      
//       oldBoardTasks.removeAt(oldItemIndex);
//       newBoardTasks.insert(newItemIndex, taskMoved);
//       box.putAt(oldListIndex, TasksBoardModel()
//         ..title = oldTitle
//         ..tasks = oldBoardTasks);
//       return box.putAt(newListIndex, TasksBoardModel()
//         ..title = newTitle
//         ..tasks = newBoardTasks);
//     }
//   }
// }