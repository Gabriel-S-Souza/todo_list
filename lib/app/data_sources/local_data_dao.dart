import 'package:hive_flutter/hive_flutter.dart';

import '../models/default_boards.dart';
import '../models/task_board_hive_adapter.dart';
import '../models/task_board_model.dart';
import 'contracts/contract_data_crud.dart';

class LocalDataDAO extends ContractDataCRUD {

  late final Box<TasksBoardModel> box;

  @override
  Future<void> create(Map<String, dynamic> data) {
    // TODO: implement create
    throw UnimplementedError();
  } 

  @override
  Future read(String id) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<void> update(String id, Map<String, dynamic> data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<void> deleteAll() async {
    box.deleteAll(box.keys.map((e) => e).toList());
  }

  Future<Box<TasksBoardModel>> openDataBase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskBoardAdapter());
    box = await Hive.openBox<TasksBoardModel>('boards_teste');

    if (box.isEmpty) {
      DefaultBoards.defaultBoards.map((e) {
        box.add(TasksBoardModel() ..title = e);
      }).toList();
      
    }
    return box;
  }
}