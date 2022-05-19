abstract class ITasksDataManager {
  Future<void> createTask(String data, int outerIndex, [int? insertIndex]);
  // Future<dynamic> readTask();
  Future<void> updateTask(String data, int innerIndex, int outerIndex);
  Future<void> deleteTask(int innerIndex, int outerIndex);
  Future<void> moveTask(int oldOuterIndex, int oldInnerIndex, int newOuterIndex, int newInnerIndex);
}