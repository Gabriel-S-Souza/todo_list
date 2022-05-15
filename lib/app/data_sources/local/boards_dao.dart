import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/task_board_model.dart';
import '../contracts/contract_crud.dart';

class BoardDAO implements ContractCRUD {

  final Box<TasksBoardModel> box = GetIt.I.get<Box<TasksBoardModel>>();

  @override
  Future<void> create(String data) {
    return box.add(TasksBoardModel()
        ..title = data
      );
  }

  @override
  Future<TasksBoardModel?> read(index) async {
    return await Future.value(box.getAt(index));
  }

  @override
  Future<List<TasksBoardModel>> readAll() async {
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

  @override
  Future<void> deleteAll() async {
    return await box.deleteAll(box.keys.map((e) => e).toList());
  }
}