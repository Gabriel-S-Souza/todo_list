abstract class ITasksDataManager {
  Future<void> createTask(String data, Map<int, String> tasks, String id);
  // Future<dynamic> readTask();
  Future<void> updateTask(String data, int innerIndex, int outerIndex);
  Future<void> deleteTask(int innerIndex, int outerIndex);
  Future<void> moveTask(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex);
}