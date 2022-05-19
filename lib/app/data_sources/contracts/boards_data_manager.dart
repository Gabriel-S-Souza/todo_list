import 'package:todo_list/app/data_sources/contracts/tasks_data_manager.dart';

abstract class IBoardsDataManager with ITasksDataManager {
  Future<void> create(String data);
  Future<dynamic> read();
  Future<void> update(int index, String data);
  Future<void> delete(int index);
  Future<void> move(int insertIndex, int oldIndex);
}