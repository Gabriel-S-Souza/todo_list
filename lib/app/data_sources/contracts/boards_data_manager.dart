abstract class IBoardsDataManager {
  void create(String data);
  dynamic read();
  void update(int index, String data);
  void delete(int index);
}