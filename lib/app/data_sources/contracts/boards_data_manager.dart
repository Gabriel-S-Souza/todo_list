abstract class IBoardsDataManager {
  Future<void> create(String data);
  Future<dynamic> read();
  Future<void> update(int index, String data);
  Future<void> delete(int index);
  Future<void> move(int insertIndex, int oldIndex);
}