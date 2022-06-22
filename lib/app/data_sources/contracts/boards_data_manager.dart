import 'package:todo_list/app/data_sources/contracts/tasks_data_manager.dart';

import '../../models/task_board_model.dart';

abstract class IBoardsDataManager with ITasksDataManager {
  Future create(String title, int position);
  Future read();
  Future update(TasksBoardModel board);
  Future delete(String id);
  Future deleteAll();
  Future createFromList(List<TasksBoardModel> list);
  Future move(int newIndex, int oldIndex);
}