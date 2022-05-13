import '../../models/task_board_model.dart';

abstract class ContractDataCRUD {
  void create(String data);
  dynamic read();
  void update(String id, Map<String, dynamic> data);
  void delete(int index);
}