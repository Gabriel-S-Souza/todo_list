import 'package:hive_flutter/hive_flutter.dart';

import '../models/default_boards.dart';
import '../models/task_board_hive_adapter.dart';
import '../models/task_board_model.dart';
import 'contracts/contract_crud.dart';

class LocalDataDAO extends ContractCRUD {

  late final Box<TasksBoardModel> box;

  @override
  Future<int> create(String data) {
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

  Future<void> openDataBase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskBoardAdapter());
    box = await Hive.openBox<TasksBoardModel>('boards_teste');

    if (box.isEmpty) {
      DefaultBoards.defaultBoards.map((e) {
        box.add(TasksBoardModel() ..title = e);
      }).toList();
      
    }
  }
}