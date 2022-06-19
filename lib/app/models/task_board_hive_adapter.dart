// import 'package:hive/hive.dart';
// import 'package:todo_list/app/models/task_board_model.dart';

// class TaskBoardAdapter extends TypeAdapter<TasksBoardModel> {
//   @override
//   final typeId = 0;

//   @override
//   TasksBoardModel read(BinaryReader reader) {
//     return TasksBoardModel()
//       ..title = reader.readString()
//       ..tasks = reader.readStringList();
//   }

//   @override
//   void write(BinaryWriter writer, TasksBoardModel obj) {
//     writer
//       ..writeString(obj.title)
//       ..writeStringList(obj.tasks);
//   }
// }