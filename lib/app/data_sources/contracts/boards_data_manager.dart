import 'package:todo_list/app/data_sources/contracts/tasks_data_manager.dart';

import '../../models/task_board_model.dart';

abstract class IBoardsDataManager with ITasksDataManager {
  Future<void> create(String data);
  Future<dynamic> read();
  Future<void> update(int index, String data);
  Future<void> delete(int index);
  Future<void> deleteAll();
  Future<dynamic> createFromList(List<TasksBoardModel> list);
  Future<void> move(int newIndex, int oldIndex);
}