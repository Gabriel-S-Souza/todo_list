import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/task_board_model.dart';
import '../contracts/boards_data_manager.dart';

class BoardDAO implements IBoardsDataManager {

  final Box<TasksBoardModel> box = GetIt.I.get<Box<TasksBoardModel>>();

  @override
  Future<void> create(String data) {
    return box.add(TasksBoardModel()
        ..title = data
      );
  }

  @override
  Future<List<TasksBoardModel>> read() async {
    return await Future.value(box.values.toList());
  }

  @override
  Future<void> update(int index, dynamic data) async {
    return await box.putAt(index, data);
  }

  @override
  Future<void> delete(int index) async {
    return await box.deleteAt(index);
  }

  Future<void> deleteAll() async {
    return await box.deleteAll(box.keys.map((e) => e).toList());
  }

  @override
  Future<void> move(int insertIndex, int oldIndex) async {
    List<TasksBoardModel> boards = box.values.toList();
    TasksBoardModel boardMoved = boards[oldIndex];
    boards.removeAt(oldIndex);
    boards.insert(insertIndex, boardMoved);
    box.clear();
    boards.map((e) {
      box.add(e);
    }).toList();
  }
}