import 'package:hive_flutter/hive_flutter.dart';

import '../models/default_boards.dart';
import '../models/task_board_hive_adapter.dart';
import '../models/task_board_model.dart';
import 'contracts/contract_data_crud.dart';

class LocalDataDAO extends ContractDataCRUD {

  late final Box<TasksBoardModel> box;

  @override
  Future<int> create(String data) {
    return box.add(TasksBoardModel()
        ..title = data
      );
  }

  @override
  List<TasksBoardModel> read() {
    return box.values.toList();
  }

  @override
  void update(String id, Map<String, dynamic> data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int index) {
    return box.delete(index);
  }

  void deleteAll() async {
    box.deleteAll(box.keys.map((e) => e).toList());
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