abstract class ITasksDataManager {
  Future<void> create(String data, int outerIndex);
  Future<dynamic> read();
  Future<void> update(String data, int innerIndex, int outerIndex);
  Future<void> delete(int innerIndex, int outerIndex);
}