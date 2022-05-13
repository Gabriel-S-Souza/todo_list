abstract class ContractCRUD {
  void create(String data);
  dynamic read();
  void update(String id, Map<String, dynamic> data);
  void delete(int index);
}