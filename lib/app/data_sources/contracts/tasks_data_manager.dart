abstract class ITasksDataManager {
  Future createTask(String data, Map<int, String> tasks, String id);
  Future updateTask(Map<int, String> tasks, String id);
  Future deleteTask(int innerIndex, Map<int, String> tasks, String id);
  Future moveTask(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex);
}