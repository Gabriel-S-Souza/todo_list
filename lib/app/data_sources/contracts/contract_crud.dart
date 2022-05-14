abstract class ContractCRUD {
  void create(String data);
  dynamic read(int index);
  void update(int index, dynamic data);
  void delete(int index);
}