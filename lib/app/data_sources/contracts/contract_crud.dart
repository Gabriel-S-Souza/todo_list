abstract class ContractCRUD {
  void create(String data);
  dynamic read(int index);
  dynamic readAll();
  void update(int index, String data);
  void delete(int index);
  void deleteAll();
}