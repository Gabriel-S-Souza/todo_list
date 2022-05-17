abstract class ITasksDataManager {
   Future<void> create(String data, int outerIndex);
  Future<dynamic> read(int outerIndex);
   Future<void> update(int innerIndex, int outerIndex, String data);
   Future<void> delete(int innerIndex, int outerIndex);
}